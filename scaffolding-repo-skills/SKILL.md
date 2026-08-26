---
name: scaffolding-repo-skills
description: >
  Use when explaining or auditing a repo skill/doc/notes system; when scaffolding
  a new project from skeletons or retrofitting an existing repo; when adding
  standing layout (AGENTS, notes dual-axis tree, postmortem, agent-gates) or
  skills (agent-notes, doc-standards, archive-agent-notes, code-review,
  pre-push-checks); when running scaffold-suite; when copying
  acceptance-console-http; or when wiring discovery shells. Templates encode
  shared flow/logic only — no product-branded content.
---

# Scaffolding repo skills

Modes: **explain** (no writes) | **scaffold** (apply templates → explore → fill `{{PLACEHOLDER}}`).

Scaffold kinds: `scaffold-system` | `scaffold-skill` | `scaffold-suite`.

Templates must stay **brand-free**: same section flow and rules as the reference system; domain facts only via placeholders filled from the **target** repo. Never paste a product repo’s standing docs into this bag as “templates”.

## Target maturity（必先判定）

在任何 scaffold 写入前，判定目标仓是 **新项目** 还是 **老项目**，并宣告采用哪条路径。不确定就问一句。

| 判定 | 信号（任一即可） | 路径 |
|---|---|---|
| **新项目** | 无根 `AGENTS.md`；无 `.agents/notes` / `.agents/skills`；几乎无站岗文档；用户明确说新仓/绿场 | **骨架生成** |
| **老项目** | 已有 `AGENTS.md` / docs / 自定义 notes 或 skills / 既有门禁；用户说改造/对齐/补体制 | **改造** |

### 新项目 — 骨架生成

1. 按模板**创建**缺失路径（可整树拷入）。
2. 跑 `create-notes-tree.sh` 铺满 notes 4×6。
3. 探索目标仓（即便很空：语言、Makefile、包名）→ 填占位符。
4. 不假装已有体制；缺什么建什么。

### 老项目 — 改造

1. **先审计**现状：已有哪些站岗文、notes 布局、skills、门；与模板流程/逻辑的差距表。
2. **禁止**用模板整文件覆盖仍有效的目标仓正文（尤其根 `AGENTS.md`、专篇、已有 Notes）。
3. 按差距**增量改造**：补缺章节/目录/壳/门；把非双轴 notes **迁到** `{lifecycle}/{class}/`；把厚 IDE skill **收成**发现壳 + `.agents/skills` 真源。
4. 模板作**对照清单与补丁源**，不是铲平重铺。合并时保留目标仓域铁律与命令，只对齐流程骨架。
5. 改造后仍 explore → 填剩余 `{{PLACEHOLDER}}`；回报「保留 / 迁移 / 新建」三类路径。

**Iron order（两条路径共通）：** 先落盘形状（新：拷模板；老：补丁/迁移）→ 再 explore 填事实。老项目不要「先生成一份完整新 AGENTS 再让人 Diff」。

## Mode selection

| Signal | Mode / kind |
|---|---|
| How it works / audit | **explain** |
| Full install | **scaffold-suite**（内部仍先做新/老判定） |
| Layout only (AGENTS/notes/gates) | **scaffold-system** |
| One skill | **scaffold-skill**（缺 system 依赖则先 system） |
| Unclear | Ask once |

## Shared rules

1. Canonical skill body: `.agents/skills/<name>/SKILL.md`. Shells: `.claude` + `.cursor` (≤40 lines) → canonical path; shell `description` **copied from** canonical frontmatter.
2. description = Use when… only (no workflow summary in description).
3. One fact, one home.
4. Notes dual-axis: `{lifecycle}/{class}/yyyy-mm-dd-topic.md` with **full 4×6 tree** (`create-notes-tree.sh`).
5. Docs gates ≠ default business `test`.
6. **AGENTS 书写原则（硬门槛）：** 正文在 `docs/AGENTS.md`（分层、一事实一家、词数预算、维护义务、放置禁令、**根 AGENTS 书写原则**）。根 `AGENTS.md` **必须**有「文档地图」且含指向该文件的一行；禁止只写一句「见 docs/AGENTS」却无地图表、或根本不建 `docs/AGENTS.md`。改造老仓时若缺上述任一 → **未完成 system**。
7. See [dependencies.md](references/dependencies.md), [explore-fill.md](references/explore-fill.md), [shapes.md](references/shapes.md), [agents-skills-section.md](references/agents-skills-section.md).

## Mode explain

Cover system package, skill shapes, **new vs retrofit**, dependency graph, AGENTS principles, notes dual-axis, audit checklist. No writes.

## scaffold-system

先做 **Target maturity** 判定。

**新项目：** 拷齐下表；跑 `create-notes-tree.sh`；再填占位符。

**老项目：** 对下表逐项审计 → 只补缺/迁布局/加门；已有文件以合并补丁为主。

| Template | Destination |
|---|---|
| `AGENTS.md` | 新：创建（含**文档地图**）；老：合并「以后怎么工作」+ **文档地图**（必含书写原则行）+ Skills；保留域摘要 |
| `docs-AGENTS.md` | `docs/AGENTS.md` — **书写原则真源**（新：创建；老：合并放置/义务/**根 AGENTS 书写原则**节；缺则补） |
| `notes-README.md` | `.agents/notes/README.md`（老：对齐合约，勿抹掉有效链） |
| `create-notes-tree.sh` | 铺/补 4×6；老仓已有 Note 文件则 **git mv** 进正确 lifecycle/class |
| `postmortem-README.md` / `postmortem-TEMPLATE.md` | `docs/postmortem/` |
| `development.md` | `docs/development.md`（老：保留命令表，补门纪律） |
| `scripts/agent-gates/*` | `scripts/agent-gates/`（老：合并 manifest，勿盲覆写已定制脚本除非等价） |
| dirs | `.agents/skills/`、`.claude/skills/`、`.cursor/skills/` |

**system 完成检查（新/老共通）：** `docs/AGENTS.md` 存在且含书写原则相关节；根 `AGENTS.md` 有文档地图并链到它；notes 4×6 + README；gates 可跑。

Wire Makefile via `Makefile.snippet` if asked.

## scaffold-skill

1. Target maturity + dependencies；缺 notes README / 4×6 → 先 system（老：改造式 system）。
2. **新：** 拷 `templates/<shape-id>/SKILL.md` → `.agents/skills/{{SKILL_DIR}}/`。**老：** 若已有同职责 skill，改造成薄触发/清单形态并迁真源到 `.agents/skills/`，不要并列第二份。
3. Shells from `references/shell-template.md`；description 与真源 frontmatter 一致。
4. `acceptance-console-http`：整包复制 vendored 树（不重写）。
5. Explore → fill；打印 AGENTS Skills 行；有门则跑 `verify-skill-shells.sh`。

## scaffold-suite

1. 判定新/老 → `scaffold-system`（骨架或改造）
2. 五个 generative skill（一致的目录名与交叉链接；老仓去重合并）
3. 可选 acceptance 复制
4. 填交叉占位符；建议 Skills 表；跑 `run-all.sh`
5. 老仓回报必须含：保留 / 迁移 / 新建

## Anti-patterns

- 老项目直接整文件覆盖仍有效的 `AGENTS.md` / 专篇 / Notes
- 新项目却「只改口不做骨架」留下半套布局
- 未判定新/老就开始写文件
- **改造完成却未落地 `docs/AGENTS.md` 书写原则，或根 AGENTS 无文档地图指向它**
- Copying a product repo’s AGENTS/domain iron rules into this bag
- Leaving product brand strings inside templates
- Long SKILL before template/patch on disk
- Thick IDE shells / handbook pasted into SKILL
- agent-notes without notes README + 4×6 tree
- Claiming done while `{{PLACEHOLDER}}` remain
