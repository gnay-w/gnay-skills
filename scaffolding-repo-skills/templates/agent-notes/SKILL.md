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

# Agent Notes（决策时刻落盘）

薄触发器：在**拍板当下**把「为什么 / 否了什么」写入 `.agents/notes`。规范真源不在本文件。

## 先读

1. [`.agents/notes/README.md`](../../notes/README.md) — 何时写、一卡一决策、lifecycle、骨架、Alternatives
2. 新建前按 [{{ARCHIVE_SKILL}}](../{{ARCHIVE_SKILL}}/SKILL.md) 做**同题 supersession** 审计

站岗摘要：根 [`AGENTS.md`](../../../AGENTS.md)「以后怎么工作」第 2 条；放置/文风见 [{{DOC_STANDARDS_SKILL}}](../{{DOC_STANDARDS_SKILL}}/SKILL.md)。

## 必须调用本 skill 的时机（主动，不等用户说「记 Note」）

任一出现即 Read 本 skill 并落盘或更新 Note：

- 头脑风暴 / 设计对话中用户确认了选项或设计节
- 明确否决某方案（含「不选 B/C」）
- 架构、鉴权、隔离、契约、配置格式、交付门取舍
- 准备写或正在写 specs|plans，且其中含新决策
- 实现中途改了原决策（新开卡或更新持有卡；禁止把旧卡改写成反面）

**跟决策，不跟流程名。** 开过 brainstorming / 写过 spec **不**免除 Note。

机械豁免（重命名、格式化、生成物、无行为契约变化）见 notes README — 可跳过。

## 落盘步骤

1. **拆卡**：一张 Note 一个可独立重审的决策；能单独推翻 → 分文件；相关卡相对链接互链
2. **路径**：`.agents/notes/{proposed|implemented|rejected}/{class}/yyyy-mm-dd-topic.md`
   - 未建成 → `proposed`；已随代码/配置落地 → `implemented`；否决 → `rejected`
   - `class`：`architecture` | `process` | `feature` | `bug-fix` | `simplification` | `testing`
3. **骨架**：按 notes README 对应 lifecycle；`## Alternatives considered` 必须有实质否决项（禁空「无」）
4. **同变更**：与产生该决策的 spec/代码同 PR；不要「以后再记」
5. **校验**：`{{GATE_COMMAND}}`

## 禁止

- 把 API 清单、逐步任务、运维命令、UI 像素写进 Note（那是 spec/plan/runbook）
- 在业务代码或站岗长文里重复维护「为什么」正文（Note 一家）
- 用本 skill 代替归档/prune（走 `{{ARCHIVE_SKILL}}`）
- 复制 notes README 全文到本 skill（改规则只改 README）

## 与其它 skill

| Skill | 分工 |
|---|---|
| **本 skill** | 决策**何时**落盘 + 最短步骤 |
| `{{ARCHIVE_SKILL}}` | supersession、归档、reject 清理 |
| `{{DOC_STANDARDS_SKILL}}` | 文档地图、词数、一事实一家、文风 |
| 上游 `brainstorming` | 出设计；**每锁一决策仍须经本 skill 写 Note** |
