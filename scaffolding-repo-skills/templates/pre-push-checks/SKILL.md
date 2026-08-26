---
name: {{SKILL_DIR}}
description: >
  Use before git push or before claiming checks passed — choose gates/tests from the
  diff; do not blindly run everything.
---

# {{SKILL_TITLE}}

<!-- Fill guide: Makefile, package.json scripts, docs/development.md; whether doc gates ⊂ test. -->

按 **diff 选门**，不要无脑全量。说明见 [`{{DEV_DOC}}`]({{DEV_DOC_REL}})。声称「已通过检查」前：列出**实际跑过的命令与结果**。

## 选门表

| 改动类型（看 `git diff` / 暂存路径） | 至少跑 |
|---|---|
{{GATE_MATRIX_ROWS}}
| 仅注释/错别字且无行为 | 可跳过业务测；若动站岗链仍跑文档门 |

## 纪律

- 文档/Notes/skill 门与业务测试门**分开**选跑（若本仓如此约定）。
- 多类改动取并集。
- 不要用「本地以前绿过」代替本 diff 的实跑证据。

## 声称通过前的最小报告

```text
diff 范围: <路径摘要>
实跑:
  - <命令> → <通过/失败摘要>
未跑及原因: <若有>
```

相关：[{{DOC_STANDARDS_SKILL}}]({{DOC_STANDARDS_REL}})；Notes 归档见 [{{ARCHIVE_SKILL}}]({{ARCHIVE_SKILL_REL}})。
