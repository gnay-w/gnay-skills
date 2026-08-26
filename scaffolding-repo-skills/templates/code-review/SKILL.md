---
name: {{SKILL_DIR}}
description: >
  Use when reviewing a PR or local change set — checklist for Notes/postmortems,
  standing-doc duplication, domain iron rules, and semantics tests cannot catch.
---

# Code Review

审本仓 PR 或本地变更集时，按下列清单过一遍。**阻塞项优先**写在前面；可合并的文档/Note 债单独列出。

## 权威链接

- 根 [`AGENTS.md`](../../../AGENTS.md)
- [`docs/AGENTS.md`](../../../docs/AGENTS.md)（分层与维护义务）
- [`.agents/notes/README.md`](../../../.agents/notes/README.md)
- [`docs/postmortem/`](../../../docs/postmortem/README.md)
{{AUTHORITY_LINKS_EXTRA}}

## 可执行清单（阻塞优先）

1. **域铁律 / 分层 / 防御模式**
{{DOMAIN_CHECK_BULLETS}}

2. **非琐碎是否缺 Agent Note / 维护义务文档（agent 本应主动写）**
   - 架构/契约/交付门/明确否决 → 同变更须有 Note（或更新既有）；**不**以「未开头脑风暴」豁免
   - 未建成应 `proposed`、已落地应 `implemented`、否决应 `rejected`；proposed 落地须同 PR 流转；implemented 不得残留 `## Proposal` / `## Acceptance criteria`
   - 机械改动可豁免；新建时是否做了同题 supersession（见 [{{ARCHIVE_SKILL}}](../{{ARCHIVE_SKILL}}/SKILL.md)）
   - 行为/契约/运维手顺/债状态/产品可见语义变了，却未按 [`docs/AGENTS.md`](../../../docs/AGENTS.md)「维护义务」更新 → **阻塞**
   - 系统性翻车只修代码、无 postmortem / 事故→门 → **阻塞**

3. **系统性事故是否缺 postmortem / 事故→门**
   - 护栏被旁路、契约接缝漏测等 → 须 postmortem，不只修代码
   - 日常单点 bug 不必强求

4. **站岗文复印或外部溯源套话**
   - 一事实多家；specs/plans 树塞站岗长文
   - 外来移植说明 / 外部项目溯源口吻

5. **门已能抓的不主菜**
   - `{{GATE_COMMAND}}` 与其它自动门能拦住的：评论点到门即可，勿复述成长篇

6. **测不动的语义**
{{SEMANTICS_BULLETS}}

## 输出格式

1. 阻塞项（必须改才合）
2. 应改项（强烈建议）
3. 文档 / Note / postmortem 债（可另 PR，但点名）
4. 已由门覆盖、仅作提醒的项（可选）
