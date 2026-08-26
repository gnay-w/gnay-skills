---
name: {{SKILL_DIR}}
description: >
  Proactively write or update Agent Notes when a non-trivial decision is locked —
  brainstorming/design A·B·C choices, rejected alternatives, architecture or contract
  tradeoffs, before/while writing specs or plans, or when the user confirms a design
  section. Also use when asked to record a decision, open a proposed note, or when
  unsure whether a choice needs a Note. Does not replace archive/supersession
  ({{ARCHIVE_SKILL}}) or standing-doc placement ({{DOC_STANDARDS_SKILL}}).
---

# {{SKILL_TITLE}}（决策时刻落盘）

<!-- Fill guide: explore notes README, root AGENTS “how we work”, sibling skill dirs. -->

薄触发器：在**拍板当下**把「为什么 / 否了什么」写入 Notes。规范真源不在本文件。

## 先读

1. [`{{NOTES_README}}`]({{NOTES_README}}) — 何时写、一卡一决策、lifecycle、骨架、Alternatives
2. 新建前按 [{{ARCHIVE_SKILL}}]({{ARCHIVE_SKILL_REL}}) 做**同题 supersession** 审计

站岗摘要：根 [`AGENTS.md`]({{ROOT_AGENTS_REL}})；放置/文风见 [{{DOC_STANDARDS_SKILL}}]({{DOC_STANDARDS_REL}})。

## 必须调用本 skill 的时机（主动，不等用户说「记 Note」）

{{TRIGGERS_BULLETS}}

**跟决策，不跟流程名。** 开过 brainstorming / 写过 spec **不**免除 Note。

机械豁免见 notes README — 可跳过。

## 落盘步骤

1. **拆卡**：一张 Note 一个可独立重审的决策；能单独推翻 → 分文件；相关卡相对链接互链
2. **路径**：`{{NOTES_PATH_PATTERN}}`
3. **骨架**：按 notes README 对应 lifecycle；`## Alternatives considered` 必须有实质否决项（禁空「无」）
4. **同变更**：与产生该决策的 spec/代码同 PR；不要「以后再记」
5. **校验**：`{{GATE_COMMAND}}`

## 禁止

{{FORBID_BULLETS}}

## 与其它 skill

| Skill | 分工 |
|---|---|
| **本 skill** | 决策**何时**落盘 + 最短步骤 |
| `{{ARCHIVE_SKILL}}` | supersession、归档、reject 清理 |
| `{{DOC_STANDARDS_SKILL}}` | 文档地图、词数、一事实一家、文风 |
| 上游 `brainstorming` | 出设计；**每锁一决策仍须经本 skill 写 Note** |
