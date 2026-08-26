---
name: acceptance-console-http
description: >-
  Drives the td-story-acceptance console over HTTP after product work is done
  and pushed to the remote (list/ensure projects, create/poll jobs, reviews,
  push campaign, merge baseline). Use when the user asks for acceptance /
  验收 / ensure_project / create_job / ACCEPT_API_TOKEN / story / doc_path / HTTPS console
  access. Do NOT use while coding is still in progress or commits are not
  pushed. Prefer HTTP from product repos; MCP is optional on the console host
  only.
---

# Acceptance console — HTTP activation (product repos)

遵守产品仓根 `AGENTS.md`；非琐碎改动写 Agent Note；提交前 `make agent-gates`（文档/Notes 变更时）。

Canonical upstream may live in **td-story-acceptance** (`skills/acceptance-console-http/`).
In this repo the **skill 真源** is `.agents/skills/acceptance-console-http/`；Claude/Cursor 目录只留发现用薄壳。

Do **not** revive old acceptance Skill / submodule / in-repo orchestrators.

## When to use（硬门槛 — 必须先读）

**全部满足才调用本 skill / 开批次：**

1. 用户明确要跑验收、开批次、ensure 项目、或审查/合入基线；**并且**
2. **相关功能开发已经完成**（不是还在改实现）；**并且**
3. **代码已 push 到远程**（`repo_url` 指向的远程上已有要验的提交）。

**禁止在这些情况下用：**

- 还在写代码 / 本地未 push / 仅 WIP 分支
- 只是询问文档、排错构建、与验收无关的开发
- 控制台未启动、没有 `ACCEPT_BASE_URL` / `ACCEPT_API_TOKEN`

若用户要求「先 ensure 项目」但代码未推：可以 ensure，**但不要开批次**，并说明须 push 后再开。

## Prerequisites (console host)

- Stack：`./deploy/up.sh`（或 infra + `pnpm --filter app dev`）
- 运行配置真源：控制台 **`deploy/.env`**（含 `ACCEPT_API_TOKEN`、`ACCEPT_ROOT`、`PORT`…）
- Worker：`CURSOR_API_KEY`（或 `WORKFLOW_FAKE_WORKERS=1`）
- `GET /api/health` 公开；其余 API 在设置了 token / AUTH 时需 Bearer

浏览器 UI 另需 session 登录；**被测仓自动化只用 Bearer**。

## Config

| Var | Meaning |
|---|---|
| `ACCEPT_BASE_URL` | 控制台 origin（无尾斜杠）。统一 **`https://tsa.tidun.cn`**；本机排错可临时 `http://127.0.0.1:3010` |
| `ACCEPT_API_TOKEN` | 与控制台 `deploy/.env` 中相同 |
| `repo_url` | **远程** git URL — 项目身份键 |
| `local_path` | **控制台主机**上的绝对路径（clone 兜底），不是调用方本机路径 |
| `baseline_branch` | 批次基线，如 `dev` |

```bash
export ACCEPT_BASE_URL="${ACCEPT_BASE_URL:-https://tsa.tidun.cn}"
export ACCEPT_API_TOKEN="…"
auth=(-H "Authorization: Bearer ${ACCEPT_API_TOKEN}" -H "Content-Type: application/json")
```

camelCase / snake_case 均可。

## 词表（故事 / 批次 / 执行项 / 取证次）

| 中文 | 含义 |
|---|---|
| **故事** | 项目内稳定验收对象（embedding 归并） |
| **批次** | 一次开跑（API：`/api/jobs` 或 `/api/batches`） |
| **执行项** | 批次内一条编排槽位（`stories[]` / `items[]`） |
| **取证次** | 一盘证据；审查挂故事下的取证次 |

## Identity rules

1. `repo_url` = 远程地址（禁止本机路径）
2. `project_id` = ensure/create **返回值**（禁止写死 UUID）
3. 已存在 `repo_url` → **ensure**，不要 create（409）
4. 单批执行项建议 ≤3，`parallelism` ≈ 执行项数

## Standard sequence

```text
1. GET  /api/health
2. POST /api/projects/ensure     → project.id
3. POST /api/jobs 或 /api/batches → job.id / batchId（仅 push 完成后）
4. GET  /api/jobs/:id            → 轮询
5. （可选）reviews / push-campaign / merge-baseline
```

---

## 各接口：填什么

### `GET /api/health`

- Auth：无  
- Body：无  
- 用途：探活

### `GET /api/projects`

- Auth：Bearer  
- Body：无  
- 返回：`{ projects: [{ id, name, repoUrl, localPath, defaultBaseline, … }] }`

### `POST /api/projects/ensure`（推荐）

| 字段 | 必填 | 数据 |
|---|---|---|
| `name` | 是 | 显示名 |
| `repo_url` | 是 | 远程 git URL |
| `local_path` | 是 | 控制台机绝对路径 |
| `default_baseline` | 否 | 默认基线；缺省 `main` |

返回：`{ project: { id, … }, created }` → 记下 **`project.id`**。

```bash
curl -sS -X POST "${auth[@]}" "$ACCEPT_BASE_URL/api/projects/ensure" -d '{
  "name": "MyProduct",
  "repo_url": "git@git.example.com:org/my-product.git",
  "local_path": "/absolute/path/on/console/host/my-product",
  "default_baseline": "dev"
}'
```

### `POST /api/projects`

字段同 ensure。冲突 409 → 改 ensure。

### `GET /api/jobs`

- Auth：Bearer；Body：无

### `POST /api/jobs`

| 字段 | 必填 | 数据 |
|---|---|---|
| `project_id` | 是 | ensure 返回的 id |
| `baseline_branch` | 是 | 如 `dev` |
| `parallelism` | 否 | 正整数，默认 3 |
| `stories` | 是 | 非空数组 |
| `stories[].slug` | 是 | 如 `fs-001`（Job 内唯一）；**不参与**身份匹配 |
| `stories[].story` | 尽量与 `doc_path` 同给 | 短意图句（见下节填槽）；同 project 内 embedding 归身份。API 仍允许只给 `story` 或只给 `doc_path`，Agent **默认都带** |
| `stories[].doc_path` | 尽量与 `story` 同给 | 相对 `local_path`；同能力各次 Job **路径字面一致**。无文档时可省略 |
| `stories[].design_anchor` | 否 | 遗留字段；新调用用 `story` / `doc_path` |

返回可含 `storyMatches[]`：`identityId`、`match`（`hit` \| `created` \| `ambiguous_new`）。

开 Job 前必须按下一节写好 `story`（有文档则同时填 `doc_path`）。

```bash
curl -sS -X POST "${auth[@]}" "$ACCEPT_BASE_URL/api/jobs" -d '{
  "project_id": "<id>",
  "baseline_branch": "dev",
  "parallelism": 3,
  "stories": [
    {
      "slug": "fs-001",
      "story": "【工作台】工作台总览：租户管理员可打开工作台，并观察到待办与汇总卡片可展示。",
      "doc_path": "docs/product/需求/管理后台/01-工作台.md"
    },
    {
      "slug": "fs-021",
      "story": "【系统管理】用户管理：租户管理员可维护用户账号与角色绑定，并观察到列表与启停状态反映变更。",
      "doc_path": "docs/superpowers/specs/2026-06-02-system-management-rbac-design.md"
    }
  ]
}'
```

### 写 story 正文（开 Job 时 · 偏严）

> 目的：不同 Agent 对**同一能力**写出足够接近的正文，稳定 embedding **`hit`** 同一身份。近义句约 0.77、命中阈值约 0.82，必须句式与关键词高度收敛。设计见 `docs/superpowers/specs/2026-08-24-acceptance-story-writing-for-identity-hit-design.md`。

**流程：**

1. 从用户 NL / 上下文抽出模块 + 能力名  
2. 能定位仓内设计/需求/PRD → 填同一字面 `doc_path`  
3. 按填槽写短 `story`（不发挥）  
4. **尽量** `story` + `doc_path` 都给；仅无文档时只给 `story`  
5. 一执行项 = 一能力 = 一条 `story`

**模板（一句，最多两句，禁止段落）：**

```text
【{模块}】{能力名}：{角色}可{关键动作}，并观察到{可判定结果}。
```

| 槽 | 规则 |
|---|---|
| 模块 | 产品一级名，不自造近义（例：工作台 / 设备台账 / 风险防控 / 制度建设 / 安管部门 / 安管人员 / 安全培训 / 应急救援 / 消息中心 / 系统管理 / 驾驶舱 / 移动端 / 平台） |
| 能力名 | 页面或能力专名；优先文档标题或 NL 专有名词；不扩成「某某模块完整 CRUD」 |
| 角色 | 短：租户管理员 / 安全员 / 平台超管 … |
| 动作+结果 | 一句内说完；不写步骤 |

长度建议 ≤80 字，硬上限约 120 字。有历史同能力且已 `hit` 的正文 → **逐字复用**。

**都带时分工：** `story` = 短意图（主信号）；`doc_path` = 路径 + 文档前 800 字（辅锚）。禁止把文档全文糊进 `story`；禁止换一份「差不多」的文档顶替同一能力。

**禁止写入 `story`：** 用户故事腔；AC/步骤/造数/口令/URL 细则；同义换花；多能力揉一句；版本号/战役名/FS-id/实现细节。

**好例：**

```text
【设备台账】设备安全档案：租户管理员可筛选并新建/编辑设备，并观察到列表与档案表单反映变更。
【应急救援】应急演练记录：租户管理员可维护演练记录，并观察到列表与详情展示已保存内容。
【驾驶舱】地图态势总览：安全负责人可打开驾驶舱全屏地图与统计卡，并观察到校区与态势信息可展示。
```

**坏例：**「作为管理员我想管理设备以便…」；「设备台账完整功能含导入导出批量…」；「验收闭环：先造数据再登录…」。
### `GET /api/jobs/:id`

轮询。关注 stories 终态、`status`（含 `awaiting_baseline_merge` / `done`）、产品 diff。无改动可能直接 `done`。

### `POST /api/jobs/:id/stop`

| 字段 | 必填 | 数据 |
|---|---|---|
| `mode` | 否 | `soft` \| `force` |

### `POST /api/jobs/:id/push-campaign`

Body 可空。推远程战役分支。

### `POST /api/jobs/:id/merge-baseline`

| 字段 | 必填 | 数据 |
|---|---|---|
| `confirm` | 是 | 必须 `true` |

须已 push。

### `GET /api/reviews`

可选查询：`projectId`、`repo`。人审列表（含身份摘要）。

### `GET /api/reviews/:storyId`

可选 `?run=<runId>`。

### `PATCH /api/reviews/:storyId`

```json
{
  "schema_version": 1,
  "groups": {
    "AC-01": { "verdict": "pass", "note": "" },
    "AC-02": { "verdict": "fail", "note": "复现步骤…" }
  }
}
```

`verdict`：`pass` \| `fail` \| `waived` \| `skipped_unresolved`。  
非 pass 必须 `note`。证据未齐会被硬闸拒绝。人审优先 Web。

---

## Errors

| HTTP | 原因 |
|---|---|
| 401 | Bearer 缺失/错误 |
| 403 | 角色不足 |
| 409 | create 时 `repo_url` 已存在 → ensure |
| 400 | 校验失败（路径非绝对、缺 stories…） |

## Product repos must NOT

- 开发中途 / 未 push 就 create_job  
- 本机路径当 `repo_url`  
- 写死 `project_id`  
- 分叉 PROTOCOL / templates  
- 控制台 consumer 没跑时期待 Job 推进  

## Copy into product repo

1. 复制本目录 → `.cursor/skills/acceptance-console-http/`  
2. `AGENTS.md` 写清：`ACCEPT_BASE_URL`、`ACCEPT_API_TOKEN`、**开发完成且 push 后才验收**  
3. API 变更以本仓 skill 为准再同步  

Endpoint 速查表：`reference-http.md`。

---

## Example: td-janus（被测仓）

**入口**：浏览器 UI `https://tsa.tidun.cn`（须 session 登录）；自动化 **仅 Bearer**，不要混用 cookie。

| 项 | 值 |
|---|---|
| `ACCEPT_BASE_URL` | `https://tsa.tidun.cn` |
| `ACCEPT_API_TOKEN` | 控制台 `deploy/.env` |
| `repo_url` | `git@git.xiujiadian.com:code/tidun/td-janus.git` |
| `local_path` | 控制台机 `/home/gnay/workspace/td-janus` |
| `baseline_branch` | `dev`（或战役分支，与 inventory 一致） |

**需求清单**（full-surface FS-*）：Git 历史  
`bcad4ac9:acceptance/inventory/full-surface-pc-cockpit.md`（当前 `dev` 工作区可能已删目录，用 `git show` 读）。

**开 Job 惯例**：

1. `POST /api/projects/ensure` → 记 `project.id`（禁止写死 UUID）  
2. 每批 ≤3 条 story，`parallelism` = 本批故事数  
3. `stories[].slug` 如 `fs-003`；**尽量**同时给填槽 `story` + 稳定 `doc_path`（见「写 story 正文」）  
4. `POST /api/jobs` 后 `GET /api/jobs/:id` 轮询；consumer 须在控制台 host 运行  

控制台 host 批量脚本（inventory 分 wave）：

```bash
pnpm --filter app janus:waves -- \
  --project-id "<ensure 返回>" \
  --janus-repo /home/gnay/workspace/td-janus \
  --baseline dev --wave 1
```

**禁止**：开发未 push 就 `create_job`；浏览器 UI 创建项目/任务（已改为 Bearer/MCP only）。
