---
name: {{SKILL_DIR}}
description: >
  Use before git push or before claiming checks passed — choose doc gates / unit
  tests / e2e from the diff; do not blindly run everything.
---

# 提交前检查

按 **diff 选门**，不要无脑全量。说明见 [`docs/development.md`](../../../docs/development.md)。声称「已通过检查」前：对照下表列出**实际跑过的命令与结果**。

## 选门表

| 改动类型（看 `git diff` / 暂存路径） | 至少跑 |
|---|---|
| 站岗文档 / Notes / postmortem / 文档链接 / `.agents/skills` / 发现壳 | `{{GATE_COMMAND}}` |
{{GATE_MATRIX_EXTRA_ROWS}}
| 仅注释/错别字且无行为 | 可跳过业务测；若动站岗链仍跑文档门 |

## 纪律

- `{{GATE_COMMAND}}` **不**默认并入业务 `test`；改文档约定后必跑，但不要因此每次推送都全量测。
- 多类改动取并集。
- 不要用「本地以前绿过」代替本 diff 的实跑证据。
- 覆盖率门仅在碰阈值/棘轮时再跑，非每次推送默认。

## 声称通过前的最小报告

```text
diff 范围: <路径摘要>
实跑:
  - <命令> → <通过/失败摘要>
未跑及原因: <若有>
```

相关：Notes 流转/归档见 [`.agents/notes/README.md`](../../../.agents/notes/README.md) 与 [{{ARCHIVE_SKILL}}](../{{ARCHIVE_SKILL}}/SKILL.md)；文档放置见 [{{DOC_STANDARDS_SKILL}}](../{{DOC_STANDARDS_SKILL}}/SKILL.md)。
