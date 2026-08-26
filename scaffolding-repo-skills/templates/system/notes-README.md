# Agent Notes

决策记忆：记录**为什么选 / 否了什么 / 后果是什么**。agent 与人按本手册写、流转、归档；机器门（`{{GATE_COMMAND}}`）只查路径、Status↔lifecycle、骨架与 class 白名单。

## 是什么 / 不是什么

| 套件 | 职责 |
|---|---|
| `.agents/notes`（本树） | 决策：为什么、否了什么、后果；后人重审时先读这里 |
| `{{SPECS_PATH}}` | 做什么、怎么拆、任务如何验收 |
| `docs/postmortem/` | 事故漏网 → 护栏（事故→门表） |
| `{{TECH_DEBT_PATH}}` | 债台账（≠ 决策正文） |

**不是**第二份 implementation plan，也不是运维 runbook。功能怎么做仍写 specs/plans；系统性事故写 postmortem，不要用 Note 代替事故→门。

## 何时必须写

非琐碎改动须在**同变更**新增或更新至少一张 Agent Note。已有 Note 持有该决策则更新之，勿重复开卡。属于下列任一即须写：

- 行为、架构、跨文件契约变化
- 流程 / 工具链 / 交付门 / 测试策略变更
- 磁盘 / 协议 / 配置格式取舍
- 明确否决过的方案（后人容易重提）
- 其它维护者可能重审的决策

**跟决策，不跟流程名。** 是否开过头脑风暴 / 是否写过 spec **不**决定要不要 Note；聊天里拍板、实现中途改取舍、PR 落地，只要决策非琐碎就必须记。

**Agent 主动义务（人不点名）：** 一旦出现明确取舍或否决、或变更落入上表，agent **主动**新增/更新 Note 并做同题 supersession，不要等用户说「记一条 Note」。决策时刻的 skill 触发面见 [`.agents/skills/{{AGENT_NOTES_SKILL}}/SKILL.md`](../skills/{{AGENT_NOTES_SKILL}}/SKILL.md)（须匹配 description 并 Read 后落盘）。

**按落地程度选 lifecycle（不是按「有没有开会」）：**

| 状态 | 何时用 |
|---|---|
| `proposed` | 实质工作**尚未建成**（或只建成一部分）；提案可用未来时 |
| `implemented` | 决策已随代码/配置**落地**；现在时写 shipped 现实；可直接进 implemented，不必强行先 proposed |
| `rejected` | 已考虑并否决；写清一行原因 |

**机械豁免**（可不同时开 Note）：重命名、格式化、生成物回写、纯错别字、无行为与契约变化的依赖小版本、局部且无行为变化的修缮。

新建 Note 前先审计同题 active notes（supersession），见 [`.agents/skills/{{ARCHIVE_SKILL}}/SKILL.md`](../skills/{{ARCHIVE_SKILL}}/SKILL.md)。

## 一张 Note 一个决策（粒度）

**所有权：** 每张 Note **只拥有一个可独立重审的决策**（一个「为什么这样 / 否了什么」边界）。已有 Note 持有该决策 → **更新它**，勿另开重复卡。

**禁止把一张 Note 改写成另一个决策。** 决策变了 → 新开 Note，与旧卡用相对 Markdown 链接互链；不要在原文上偷换成相反结论。

**同一次需求 / 同一 PR 可以多张 Note。** 相关但不等于同一决策。拆分口诀：

> 能否单独说「只改这个、其它决策不动」？能 → **分文件**；拆开后另一半没有独立的 why/why-not → **合进同一张**（或只写进 Consequences / Related 一句）。

**校准：**

| 宜分卡 | 宜同卡 |
|---|---|
| {{CALIBRATION_SPLIT_1}} | {{CALIBRATION_MERGE_1}} |
| {{CALIBRATION_SPLIT_2}} | {{CALIBRATION_MERGE_2}} |
| {{CALIBRATION_SPLIT_3}} | {{CALIBRATION_MERGE_3}} |

**不放进 Note：** API 路径罗列、逐步任务、运维命令、UI 像素级对照（交付约束写 spec；除非形成新设计系统决策）。

**交叉引用：** Note↔Note 用相对链接，勿用裸编号或「见上一张」。

## 取代与合并

- **部分取代：** 两张都留，互链；只更新仍成立的事实。任一仍独立有用的否决项、边界或负面保证 → 算部分取代。
- **全量取代：** 新卡吸收旧卡全部仍有价值的 rationale / Alternatives / Consequences / 验证要点后，旧 **implemented** 可按 archive skill 归档（或在确认无未来指导价值且内容已迁走后处理）；修好全部入站链接。不得把旧文件改写成其反面，也不得只靠 git 历史当唯一副本。
- **功能新增卡合并进后续「移除」卡：** 仅当该能力已从生产代码、配置、schema、迁移与兼容路径消失，文档不再宣称为可用，且无测试再把它当受支持行为——否则仍是部分取代。

## 路径双轴

```text
.agents/notes/{lifecycle}/{class}/yyyy-mm-dd-topic.md
```

**lifecycle**（封闭）：`proposed` | `implemented` | `rejected` | `archived`

**class**（封闭）：`architecture` | `process` | `feature` | `bug-fix` | `simplification` | `testing`

- 文件内 `Status:` 必须与所在 lifecycle 目录一致；`rejected` 允许 `Status: rejected — <一行原因>`。
- `archived/` 下仍按 class 分子目录；归档文件**不是**现行行为权威。
- 非法 class 目录名会被 `verify-agent-note-classification` 拒绝。

**目录必须预先铺齐：** 四种 lifecycle × 六种 class（可用 `.gitkeep` 占位）。scaffold 用 `create-notes-tree.sh`。

## 流转表（逐行可执行）

| 流转 | 动作 |
|---|---|
| `proposed → implemented` | `git mv` 到 `implemented/{class}/`；`Status: implemented`；把 `## Proposal` **改写为现在时** `## Decision`；把 Acceptance criteria / Risks **折入** `## Consequences`（或现在时验证说明）；补齐实质 `## Alternatives considered`。**禁止** implemented 文件再含 `## Proposal` 或 `## Acceptance criteria` |
| `proposed → rejected` | `git mv` 到 `rejected/{class}/`；`Status: rejected — <一行原因>`；保留提案骨架（`## Proposal` + `## Alternatives considered`）；写清否决了什么与为何 |
| `implemented → archived` | **仅** implemented 可归档；按「未来指导价值」判断（见 archive skill）；`git mv` 到 `archived/{class}/`；保留 `Status: implemented`；在 Status 下加一行 `Archived: YYYY-MM-DD`。**不做**冻结 manifest；archived 不作现行权威 |
| rejected 清理 | 仅当否决案**不再**防「诱人误判」时可删除，并修掉入站链接；否则保留。proposed **永不** archive——过时则 reject |

同 PR 落地 proposed 时，流转与代码变更一起提交。

## Alternatives considered（强制）

`proposed` / `implemented` / `rejected` 均须有实质的 `## Alternatives considered`：写清否决了哪些候选项、为何落选。**禁止**空「无」或只写「暂无」。机器门只查章节标题是否存在；实质内容由本手册与 review 强制。

## 正文骨架示例

### proposed

```markdown
# Agent Note: <标题>

Status: proposed

## Problem
…

## Proposal
…

## Alternatives considered
…（实质否决项，禁止空「无」）

## Acceptance criteria
…

## Risks
…
```

### implemented

```markdown
# Agent Note: <标题>

Status: implemented

## Problem
…

## Decision
…（现在时；由 Proposal 改写而来）

## Alternatives considered
…

## Consequences
…（含原 AC/Risks 的现在时说明）
```

implemented **不得**再出现 `## Proposal` 或 `## Acceptance criteria`。

### rejected

```markdown
# Agent Note: <标题>

Status: rejected — <一行原因>

## Problem
…

## Proposal
…（被否决的方案）

## Alternatives considered
…（含采纳项或其它否决项）
```

rejected **不强制** `## Decision` / `## Consequences`。

## 归档原则（摘要）

- 按**未来指导价值**判断 keep vs archive；**禁止**按字数或年龄归档。
- proposed 过时 → reject，永不 archive。
- rejected：仍防诱人误判则保留，否则删除并修入站链接。
- 归档动作与校准举例见 [`.agents/skills/{{ARCHIVE_SKILL}}/SKILL.md`](../skills/{{ARCHIVE_SKILL}}/SKILL.md)。

## 校验

```bash
{{GATE_COMMAND}}
```

含 Note 格式（lifecycle 骨架差异）、class 白名单、词数预算、禁止路径、站岗链接、skill 发现壳。提交含 Note / 站岗文 / skill 变更前请手跑。
