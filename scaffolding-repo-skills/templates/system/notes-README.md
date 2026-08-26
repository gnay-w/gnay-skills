# Agent Notes

决策记忆：记录**为什么选 / 否了什么 / 后果是什么**。agent 与人按本手册写、流转、归档；机器门（`{{GATE_COMMAND}}`）只查路径、Status↔lifecycle、骨架与 class 白名单。

## 是什么 / 不是什么

| 套件 | 职责 |
|---|---|
| `.agents/notes`（本树） | 决策：为什么、否了什么、后果 |
| `{{SPECS_PATH}}` | 做什么、怎么拆、任务如何验收 |
| `docs/postmortem/` | 事故漏网 → 护栏（事故→门表） |
{{NOTES_VS_EXTRA_ROWS}}

**不是**第二份 implementation plan，也不是运维 runbook。系统性事故写 postmortem，不要用 Note 代替事故→门。

## 何时必须写

非琐碎改动须在**同变更**新增或更新至少一张 Agent Note。已有 Note 持有该决策则更新之，勿重复开卡：

- 行为、架构、跨文件契约变化
- 流程 / 工具链 / 交付门 / 测试策略变更
- 磁盘 / 协议 / 配置格式取舍
- 明确否决过的方案（后人容易重提）
- 其它维护者可能重审的决策

**跟决策，不跟流程名。** agent **主动**落盘，不等用户说「记一条 Note」。决策时刻 skill：[`{{NOTES_SKILL_LINK}}`]({{NOTES_SKILL_LINK}})。

| 状态 | 何时用 |
|---|---|
| `proposed` | 实质工作尚未建成 |
| `implemented` | 决策已随代码/配置落地（可直接进，不必先 proposed） |
| `rejected` | 已考虑并否决；写清一行原因 |

**机械豁免：** 重命名、格式化、生成物回写、纯错别字、无行为与契约变化的依赖小版本、局部且无行为变化的修缮。

新建前 supersession：[`{{ARCHIVE_SKILL_LINK}}`]({{ARCHIVE_SKILL_LINK}})。

## 一张 Note 一个决策

每张 Note **只拥有一个可独立重审的决策**。已有卡持有该决策 → **更新它**。禁止把旧卡改写成相反决策——应变则新开卡并互链。

同一次需求可多张 Note。口诀：能否单独说「只改这个」？能 → 分文件。

**不放进 Note：** API 路径罗列、逐步任务、运维命令、UI 像素级对照。

## 取代与合并

- **部分取代：** 两张都留，互链。
- **全量取代：** 新卡吸收仍有价值要点后，旧 implemented 可归档；修好入站链接。
- proposed 过时 → reject，**永不** archive。

## 路径双轴

```text
.agents/notes/{lifecycle}/{class}/yyyy-mm-dd-topic.md
```

**lifecycle：** `proposed` | `implemented` | `rejected` | `archived`  
**class：** `architecture` | `process` | `feature` | `bug-fix` | `simplification` | `testing`

- 文件内 `Status:` 必须与 lifecycle 目录一致；`rejected` 允许 `Status: rejected — <一行原因>`。
- archived 是历史快照，不是现行权威。

## 流转表

| 流转 | 动作 |
|---|---|
| `proposed → implemented` | `git mv`；`Status: implemented`；`## Proposal` → 现在时 `## Decision`；AC/Risks 折入 `## Consequences`；禁止残留 Proposal/AC |
| `proposed → rejected` | `git mv`；`Status: rejected — …`；保留提案骨架 |
| `implemented → archived` | 仅 implemented；按未来指导价值；Status 下加 `Archived: YYYY-MM-DD`；不做冻结 manifest |
| rejected 清理 | 不再防诱人误判则可删并修链 |

## Alternatives considered（强制）

`proposed` / `implemented` / `rejected` 均须有实质 `## Alternatives considered`。**禁止**空「无」。

## 正文骨架

见同目录 skill 袋内 `templates/system/notes-skeletons/`（或本仓 `_skeletons/` 若已拷入）。摘要：

- **proposed：** Problem / Proposal / Alternatives / Acceptance criteria / Risks  
- **implemented：** Problem / Decision / Alternatives / Consequences（无 Proposal/AC）  
- **rejected：** Problem / Proposal / Alternatives；`Status: rejected — …`

## 归档原则（摘要）

按**未来指导价值**判断；禁止按字数或年龄。细则见 archive skill。

## 校验

```bash
{{GATE_COMMAND}}
```
