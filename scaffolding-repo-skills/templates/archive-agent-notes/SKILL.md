---
name: {{SKILL_DIR}}
description: >
  Use when adding, auditing, archiving, or pruning rejected Agent Notes —
  supersession checks, keep-vs-archive by future value, reject obsolete proposals,
  delete stale rejections.
---

# {{SKILL_TITLE}}

<!-- Fill guide: notes README lifecycle; gate command; 1–2 keep/archive examples from this repo. -->

缩小 active 决策语料，但不擦掉仍能指导后续工作的历史。对每张 Note **按语义**判断；字数与年龄只作发现辅助，**永不当归档标准**。

## 先读合约

先读 [`{{NOTES_README}}`]({{NOTES_README_REL}})。用当前代码、配置、更新的 Note、入站链接判断：这张 Note 是否仍**持有或约束**某个决策。

## 新建 Note 时审计 supersession

先确认新卡符合「一张 Note 一个决策」。

每张新 Note 触发一次**同题** scoped 审计（proposed / implemented / rejected）：

- 全量被取代的 implemented → 新卡吸收仍有价值要点后归档旧卡；修好入站链接
- 部分重叠或仍独立有用 → 保留并交叉链接
- 过时 proposed → reject（写清原因），**永不** archive
- 不再防诱人误判的 rejected → 删除并修入站链接
- **禁止**把旧 Note 正文改写成相反决策；应用新卡 supersede

## 按未来价值分类

- **Implemented — keep active：** rationale / 否决项 / 负面保证 / 协议语义 / 安全边界仍可能指导未来改动
- **Implemented — archive：** 已落地且不太可能再指导未来工作
- **Proposed — never archive：** 不追则 reject
- **Rejected — keep：** 落败方案仍诱人且 Note 解释了为何落败
- **Rejected — delete：** 过时/不再可信；删后修入站链接

## 校准举例（本仓）

**Keep implemented：**

{{KEEP_EXAMPLES}}

**Archive implemented：**

{{ARCHIVE_EXAMPLES}}

**Rejected keep / delete：**

{{REJECTED_EXAMPLES}}

## 归档一张 implemented

1. `git mv`：按 notes README 转到 archived 路径（仅 implemented 可进 archived）
2. 保留 `Status: implemented`；Status 下一行加 `Archived: YYYY-MM-DD`；不做冻结 manifest
3. 修 active 入站链接
4. 跑 `{{GATE_COMMAND}}`

## 校验与回报

按 [{{PRE_PUSH_SKILL}}]({{PRE_PUSH_REL}}) 选门；至少 `{{GATE_COMMAND}}`。

回报：保留/归档的 implemented、保留/删除的 rejected、reject 的 proposed、边界案例与选择。
