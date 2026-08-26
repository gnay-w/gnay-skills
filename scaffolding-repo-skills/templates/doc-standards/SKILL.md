---
name: {{SKILL_DIR}}
description: >
  Use when writing or editing standing docs, postmortems, documentation maps,
  or Agent Note prose/placement — enforces single source of truth, word budgets, and
  native prose. For the moment a design/brainstorming decision is locked, prefer
  {{AGENT_NOTES_SKILL}} first; use this skill for doc map, budgets, and style.
---

# 文档标准

写/改站岗文档、Agent Note、postmortem 或文档地图前，先读 [`docs/AGENTS.md`](../../../docs/AGENTS.md)（分层与写作标准）与根 [`AGENTS.md`](../../../AGENTS.md)（每会话铁律摘要）。

## 一事实一家

- 改规则只改**一家**正文；别处摘要 + 链接。
- 根 AGENTS 与专篇冲突时，以专篇为准并立刻修根摘要。
- 禁止在 specs/plans 树再写一份站岗长文「备份」。
- 禁止恢复已否决的第二权威文档路径（见 agent-gates forbidden list）。

## 放置表（摘要）

| 写什么 | 放哪 |
|---|---|
| 每会话短铁律、文档地图、skill 索引 | 根 `AGENTS.md` |
| 某域唯一正文 | `docs/*.md` 专篇 |
| 为什么选 / 否了什么 | [`.agents/notes/`](../../../.agents/notes/README.md) |
| 事故漏网 → 护栏 | `docs/postmortem/` |
| 功能怎么做、怎么拆 | `{{SPECS_PATH}}` |
| 债台账 | `{{TECH_DEBT_PATH}}` |
| 运维命令 | `{{OPS_RUNBOOK_PATH}}` |
| Skill 流程正文 | `.agents/skills/<name>/SKILL.md`（Claude/Cursor 仅发现壳） |

细则与禁令见 [`docs/AGENTS.md`](../../../docs/AGENTS.md)。

## 词数预算（硬顶）

| 文件 | 上限（`wc -w`） |
|---|---|
| 根 `AGENTS.md` | {{WORD_BUDGET_ROOT}} |
| `docs/AGENTS.md` | {{WORD_BUDGET_DOCS_AGENTS}} |

超顶 → `{{GATE_COMMAND}}` 失败。需要更多细节时拆专篇或 Note，**不要**抬预算绕过。

## 何时写 Agent Note

决策**拍板当下**的强制落盘步骤见 **[{{AGENT_NOTES_SKILL}}](../{{AGENT_NOTES_SKILL}}/SKILL.md)**。

合约摘要：非琐碎决策须同变更新增或更新 Note；一张一决策；主动、不等用户点名。骨架与 lifecycle 见 [`.agents/notes/README.md`](../../../.agents/notes/README.md)；supersession / 归档见 [{{ARCHIVE_SKILL}}](../{{ARCHIVE_SKILL}}/SKILL.md)。本 skill 管放置表、词数、文风，不替代 `{{AGENT_NOTES_SKILL}}` 的触发。

## 何时写 Postmortem

系统性事故——修复同时 **主动** 写 `docs/postmortem/` 并更新「事故→门」表。单点笔误修完即止的不算。不要用 Note 代替事故→门。

## 维护义务（摘要）

行为 / 契约 / 铁律 / 运维手顺变了，同变更更新义务表对应文档（缺 = review 阻塞）。真源表见 [`docs/AGENTS.md`](../../../docs/AGENTS.md)#维护义务。

保鲜：站岗与代码冲突先改文档真源（或同 PR 一起改）；specs/plans 不当现行权威；路径/命令变了必须改 runbook。

## 文风

写成**本仓自身规范**：直接写机制、路径、义务与后果。禁止外来移植说明或把规范写成「参考外部项目如何做」的溯源套话。

## 提交前

改了站岗文档、Notes、postmortem、skill 或文档链接后：

```bash
{{GATE_COMMAND}}
```

业务测试门按 [{{PRE_PUSH_SKILL}}](../{{PRE_PUSH_SKILL}}/SKILL.md) 与 [`docs/development.md`](../../../docs/development.md) 按 diff 选跑；文档门 **不**默认并入业务 `test`。
