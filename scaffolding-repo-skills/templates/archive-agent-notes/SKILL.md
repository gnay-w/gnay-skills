---
name: {{SKILL_DIR}}
description: >
  Use when adding, auditing, archiving, or pruning rejected Agent Notes —
  supersession checks, keep-vs-archive by future value, reject obsolete proposals,
  delete stale rejections.
---

# Archive Agent Notes

缩小 active 决策语料，但不擦掉仍能指导后续工作的历史。对每张 Note **按语义**判断；字数与年龄只作发现辅助，**永不当归档标准**。

## 先读合约

先读 [`.agents/notes/README.md`](../../notes/README.md)（何时写、流转、骨架、Alternatives）。用当前代码、配置、更新的 Note、入站链接判断：这张 Note 是否仍**持有或约束**某个决策。

## 新建 Note 时审计 supersession

先确认新卡符合 notes README「一张 Note 一个决策」：不要把两个可独立重审的决策捏进一张；也不要为同一决策再开重复卡。

每张新 Note 触发一次**同题** scoped 审计：覆盖同一决策、同一机制、或同一否决候选项的 active notes（proposed / implemented / rejected）。在写新 Note 的同变更内分类：

- 全量被取代的 implemented → 新卡吸收仍有价值的 rationale/Alternatives/Consequences/验证要点后，按下方标准归档旧卡；修好入站链接
- 部分重叠或仍独立有用 → 保留并交叉链接（任一仍成立的边界/否决项即算部分）
- 过时 proposed → reject（写清原因），**永不** archive
- 不再防诱人误判的 rejected → 删除并修入站链接
- **禁止**把旧 Note 正文改写成相反决策；应用新卡 supersede

已知匹配不要拖到「以后再扫语料」。

## 按未来价值分类

- **Implemented — keep active：** 其 rationale、否决项、负面保证、持久化/线协议语义、所有权边界、安全规则、或「何时可再引入」条件，仍可能指导未来改动。长短不论。
- **Implemented — archive：** 已落地且正文不太可能再指导未来工作——例如一次性文案微调、窄适配器、已关闭的小 bug、已被取代的实现细节、现行行为已在站岗专篇显然的过程史。
- **Proposed — never archive：** 仍值得追就保持 proposed；不再值得则 `Status: rejected — …` 并满足 rejected 骨架。
- **Rejected — keep：** 落败方案仍是诱人、有意义的误判，且 Note 解释了为何落败。
- **Rejected — delete：** 想法已过时、被取代、不再可信、或不太可能再被重提；删除后修或删入站链接。

不要为凑配额归档。范围内每张都看；同类按同一原则；边界案例在交接里写清选择。

## 校准举例（本仓）

**Keep implemented：**

{{KEEP_EXAMPLES}}

**Archive implemented（示例形态）：**

{{ARCHIVE_EXAMPLES}}

**Rejected：**

{{REJECTED_EXAMPLES}}

## 归档一张 implemented

1. `git mv`：`implemented/{class}/foo.md` → `archived/{class}/foo.md`（仅 implemented 可进 archived）
2. 保留 `Status: implemented`；在 Status **下一行**插入 `Archived: YYYY-MM-DD`（归档日）。不做其它正文改写；**不写**冻结 manifest / hash 封印
3. 搜 active 入站链接：改指现行权威，或仅在有意引用历史快照时改指 archived 路径；不要为修链去改 archived 正文
4. 跑 `{{GATE_COMMAND}}`

archived 可作入站链接目标，但是**历史快照**，不是现行行为权威。

## 校验与回报

按 [{{PRE_PUSH_SKILL}}](../{{PRE_PUSH_SKILL}}/SKILL.md) 选门；至少 `{{GATE_COMMAND}}`。

回报：保留的 implemented、归档的 implemented、保留/删除的 rejected、若有则列出被 reject 的 proposed、以及每个真正边界案例与所选结果。不要声称 archived 出站链接已校验（默认不对 archived 出站链做机器门）。
