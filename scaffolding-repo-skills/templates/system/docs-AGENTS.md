# 文档分层与写作标准（Agent）

本文件规定本仓**文档怎么放、谁是唯一真源、何时必须写 Note / Postmortem**。站岗铁律见根 [`AGENTS.md`](../AGENTS.md)；本文件只管文档体系本身。

## 分层表

| 位置 | 管什么 | 不放什么 |
|---|---|---|
| 根 [`AGENTS.md`](../AGENTS.md) | 每会话站岗：短铁律、「以后怎么工作」、文档地图与 skill 索引 | 长篇教程、完整域专篇正文、历史决策叙事 |
| `docs/*.md` 专篇 | 某一域的**唯一正文** | 与根 AGENTS 重复的整段复印；对照学习笔记 |
| [`.agents/notes/`](../.agents/notes/README.md) | 为什么选 / 否了什么；非琐碎改动的决策记忆 | 功能怎么做的逐步 plan；运维命令 |
| [`.agents/skills/`](../.agents/skills/) | Agent skill **正文真源**；Claude/Cursor 目录仅发现壳 | 在 `.claude/skills` / `.cursor/skills` 复制整份流程 |
| [`docs/postmortem/`](postmortem/README.md) | 系统性事故：漏网分析 → 护栏 | 日常 bug 流水账；未落地的设想 |
| `{{SPECS_PATH}}` | 功能做什么、怎么拆、任务验收 | Agent 站岗长文、文档分层标准、日常铁律正文 |
| `{{TECH_DEBT_PATH}}` | 债台账与优先级 | 决策替代品；事故叙事 |
| `{{OPS_RUNBOOK_PATH}}` | 运维命令真源（若有） | 架构设计；产品背景 |
{{PLACEMENT_EXTRA_ROWS}}

## 一事实一家

- 改规则只改**一家**正文；别处只保留摘要 + 链接。
- 根 AGENTS 出现与专篇冲突时，以专篇为准并立刻修根摘要。
- 禁止在 specs/plans 树再写一份站岗长文「备份」。

## 词数预算（硬顶）

| 文件 | 上限（`wc -w`） |
|---|---|
| 根 `AGENTS.md` | {{WORD_BUDGET_ROOT}} |
| `docs/AGENTS.md`（本文件） | {{WORD_BUDGET_DOCS_AGENTS}} |

超顶由 `{{GATE_COMMAND}}` 失败。需要更多细节时拆专篇或 Note，**不要**抬预算绕过。

## 何时写 Agent Note

非琐碎改动（架构取舍、契约行为变化、交付门变更、明确否决某方案）须在同变更中新增或更新 [`.agents/notes`](../.agents/notes/README.md)。**一张 Note 一个决策**（可独立重审则分卡；同需求可多张；禁止把旧卡改写成另一决策）。**跟决策不跟流程名**；agent **主动**落盘。拍板当下触发面见 [`{{AGENT_NOTES_SKILL}}`](../.agents/skills/{{AGENT_NOTES_SKILL}}/SKILL.md)。未建成→`proposed`，已落地→`implemented`，否决→`rejected`。机械改动可豁免。粒度/取代/流转见 notes README 与 [`{{ARCHIVE_SKILL}}`](../.agents/skills/{{ARCHIVE_SKILL}}/SKILL.md)。

## 何时写 Postmortem

系统性事故（契约接缝漏测导致生产/交付翻车、关键护栏被旁路等）——agent **主动**写 [`docs/postmortem`](postmortem/README.md) 并更新「事故→门」表。单点笔误修完即止的不算。不要用 Note 代替事故→门。

## 维护义务

行为 / 契约 / 铁律 / 运维手顺变了，**同变更**必须更新义务表对应文档（缺文档 = review 阻塞；无新机器门）。按需取交集，不要无脑全开。

| 变更类型 | 必须更新 |
|---|---|
| 站岗铁律 / 分层 / 域专篇策略 | 对应 `docs/*.md` 专篇；根 [`AGENTS.md`](../AGENTS.md) 仅在摘要漂移时修 |
| 非琐碎决策 / 否决 | [`.agents/notes`](../.agents/notes/README.md) |
| 系统性事故 → 护栏 | [`docs/postmortem`](postmortem/README.md) + 事故→门 |
| 运维命令 / 端口 / CLI 手顺 | `{{OPS_RUNBOOK_PATH}}`（若本仓有） |
| Skill 工作流 | [`.agents/skills/`](../.agents/skills/)（Claude/Cursor 壳仅发现，不复印正文） |
| 已确认债项状态 / 优先级 | `{{TECH_DEBT_PATH}}`（若有） |
| 产品能力边界（对用户可见语义变了） | 产品文档路径（若有） |

**保鲜：**

- 站岗文与代码冲突 → **先改文档真源**，或同 PR 代码+文档一起改；禁止长期「代码已变、站岗仍旧」
- specs/plans 是历史任务记录，**不**当现行行为权威；现行以专篇 / Notes / 代码为准
- 机械改动仍豁免开 Note，但若命令/路径变了而 runbook 仍写旧值 → 必须改 runbook

## 放置禁令

- **Agent 站岗长文禁止放入 specs/plans 树**（该树只留 specs/plans 与产品向设计）。
- 禁止恢复已否决的第二权威文档树（名单见 `scripts/agent-gates` forbidden paths）。
- 禁止把规范写成「外来移植说明」；直接写本仓机制、路径与义务。

## 提交前

改了站岗文档、Notes、postmortem 或文档链接后，本地跑 `{{GATE_COMMAND}}`。业务测试门见 [`development.md`](development.md)。
