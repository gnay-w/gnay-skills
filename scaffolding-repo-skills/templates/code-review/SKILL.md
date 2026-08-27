---
name: {{SKILL_DIR}}
description: >
  Use when reviewing a PR or local change set — Notes/postmortems, standing-doc
  duplication, domain iron rules, and semantics that tests and gates cannot catch.
---

# Code Review

**本 skill 是指引，不是完整 checklist。** 先确认变更范围（PR 的 live base/head，或本地 diff 基线），读完 diff 以及足够的周围代码理解设计后再下结论。优先正确性、生命周期、安全与必备行为是否被破坏，而非风格；一条有证据的阻塞项，好过一长串 nits。

## 权威源

- 根 [`AGENTS.md`](../../../AGENTS.md)
- [`docs/AGENTS.md`](../../../docs/AGENTS.md)（分层与维护义务）
- [`.agents/notes/README.md`](../../../.agents/notes/README.md)
- [`docs/postmortem/`](../../../docs/postmortem/README.md)
- [{{ARCHIVE_SKILL}}](../{{ARCHIVE_SKILL}}/SKILL.md)、[{{DOC_STANDARDS_SKILL}}](../{{DOC_STANDARDS_SKILL}}/SKILL.md)（按需）
{{AUTHORITY_LINKS_EXTRA}}

## 阻塞要求

1. **域铁律 / 分层 / 防御模式**
{{DOMAIN_CHECK_BULLETS}}

2. **非琐碎决策与维护义务**
   - 架构/契约/交付门/明确否决 → 同变更须有 Note（或更新既有）；**不**以「未开头脑风暴」豁免
   - 未建成应 `proposed`、已落地应 `implemented`、否决应 `rejected`；proposed 落地须同 PR 流转；implemented 不得残留 `## Proposal` / `## Acceptance criteria`
   - 机械改动可豁免；新建时是否做了同题 supersession（见 [{{ARCHIVE_SKILL}}](../{{ARCHIVE_SKILL}}/SKILL.md)）
   - 行为/契约/运维手顺/债状态/产品可见语义变了，却未按 [`docs/AGENTS.md`](../../../docs/AGENTS.md)「维护义务」更新 → **阻塞**

3. **系统性事故须有 postmortem / 事故→门**
   - 护栏被旁路、契约接缝漏测等 → 须 postmortem，不只修代码
   - 日常单点 bug 不必强求

4. **站岗文复印或外部溯源套话**
   - 一事实多家；specs/plans 树塞站岗长文
   - 外来移植说明 / 外部项目溯源口吻

5. **必备证据存在**
   - 作者应对本 diff 跑过相关本地检查；CI 覆盖其应覆盖的矩阵。点名语义空档（门与测试都抓不到的）
   - `{{GATE_COMMAND}}` 与其它自动门能拦住的：评论点到门即可，勿复述成长篇

## 手工检查

- **意图与接口契约：** 追踪每个变更接口的两侧；实现是否与 PR / Agent Note 一致（含错误、取消、所有权、释放）
- **范围、所有权与必要性：** 每个抽象、状态机、选项、防御性拷贝、兼容路径是否对应现有契约与生产消费者；挑战无关功能与投机性泛化
- **测试力度：** 断言要能在目标回归上失败，并验证外部状态 / 日志 / 事件 / 释放，而非复述实现或轻信报告；覆盖率 ≠ 场景正确
- **Implemented Note 与落地一致：** proposed 落地时同 diff 迁到 implemented 并改写为现在时已交付状态；核路径 / 名称 / 机制
{{SEMANTICS_BULLETS}}

## 汇报发现

写清缺陷、位置、影响与证据。局部缺陷贴在最紧的 diff 范围；跨切面架构 / 范围 / 综合放到 PR 级评论。阻塞与建议分开；门已绿能拦住的不要再当主菜。回复走既有 review 线程。接到 review 时按技术依据核实后修复或反驳，不做表演性附和。
