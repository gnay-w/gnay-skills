---
name: {{SKILL_DIR}}
description: >
  Use when reviewing a PR or local change set — checklist for {{REVIEW_FOCUS_PHRASE}},
  Notes/postmortems, standing-doc duplication, and semantics tests cannot catch.
---

# {{SKILL_TITLE}}

<!-- Fill guide: standing iron-law docs; Notes/postmortem rules; what make test / gates already catch. -->

审本仓 PR 或本地变更集时，按下列清单过一遍。**阻塞项优先**；文档/Note 债可另列。

## 权威链接

{{AUTHORITY_LINKS}}

## 可执行清单（阻塞优先）

1. **{{DOMAIN_CHECK_TITLE}}**
{{DOMAIN_CHECK_BULLETS}}

2. **非琐碎是否缺 Agent Note / 维护义务文档**
   - 架构/契约/交付门/明确否决 → 同变更须有 Note（或更新既有）
   - lifecycle 与 notes README 一致；新建是否做了 supersession（见 [{{ARCHIVE_SKILL}}]({{ARCHIVE_SKILL_REL}})）
   - 行为/契约变了却未按文档维护义务更新 → **阻塞**
   - 系统性翻车只修代码、无 postmortem → **阻塞**（若本仓有 postmortem 约定）

3. **站岗文复印或外部溯源套话**
   - 一事实多家；站岗长文塞进 specs/plans 树
   - 外来移植说明口吻

4. **门已能抓的不主菜**
   - `{{GATE_COMMAND}}` 与其它自动门能拦住的：点到门即可，勿复述成长篇

5. **测不动的语义**
{{SEMANTICS_BULLETS}}

## 输出格式

1. 阻塞项（必须改才合）
2. 应改项（强烈建议）
3. 文档 / Note / postmortem 债（可另 PR，但点名）
4. 已由门覆盖、仅作提醒的项（可选）
