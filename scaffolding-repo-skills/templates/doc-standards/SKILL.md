---
name: {{SKILL_DIR}}
description: >
  Use when writing or editing standing docs, postmortems, documentation maps,
  or Agent Note prose/placement — enforces single source of truth, word budgets, and
  native prose. For the moment a design/brainstorming decision is locked, prefer
  {{AGENT_NOTES_SKILL}} first; use this skill for doc map, budgets, and style.
---

# {{SKILL_TITLE}}

<!-- Fill guide: read docs/AGENTS.md (or equivalent), root AGENTS map, budgets, maintenance table. -->

写/改站岗文档、Agent Note、postmortem 或文档地图前，先读 [`{{DOCS_AGENTS}}`]({{DOCS_AGENTS_REL}}) 与根 [`AGENTS.md`]({{ROOT_AGENTS_REL}})。

## 一事实一家

- 改规则只改**一家**正文；别处摘要 + 链接。
- 根 AGENTS 与专篇冲突时，以专篇为准并立刻修根摘要。
- {{SINGLE_SOURCE_EXTRA_BULLETS}}

## 放置表（摘要）

| 写什么 | 放哪 |
|---|---|
{{PLACEMENT_TABLE_ROWS}}
| Skill 流程正文 | `.agents/skills/<name>/SKILL.md`（Claude/Cursor 仅发现壳） |

细则见 [`{{DOCS_AGENTS}}`]({{DOCS_AGENTS_REL}})。

## 词数预算（硬顶）

| 文件 | 上限（`wc -w`） |
|---|---|
{{WORD_BUDGET_ROWS}}

超顶 → `{{GATE_COMMAND}}` 失败。需要更多细节时拆专篇或 Note，**不要**抬预算绕过。

## 何时写 Agent Note

决策**拍板当下**见 **[{{AGENT_NOTES_SKILL}}]({{AGENT_NOTES_REL}})**。本 skill 管放置表、词数、文风，不替代其触发。

## 何时写 Postmortem

{{POSTMORTEM_RULE}}

## 维护义务（摘要）

行为 / 契约 / 铁律 / 运维手顺变了，同变更更新义务表对应文档。

| 变更 | 至少 |
|---|---|
{{MAINTENANCE_TABLE_ROWS}}
| Skill 流程 | `.agents/skills/`（壳不复印） |

## 文风

写成**本仓自身规范**：直接写机制、路径、义务与后果。禁止外来移植说明或外部项目溯源套话。

## 提交前

```bash
{{GATE_COMMAND}}
```

业务测试门按 [{{PRE_PUSH_SKILL}}]({{PRE_PUSH_REL}}) 按 diff 选跑。
