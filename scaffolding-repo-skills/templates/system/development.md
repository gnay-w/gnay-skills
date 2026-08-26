# 本地开发与质量门

本地命令、生成、提交前手跑哪些门——本文件为真源。运维命令细节见 `{{OPS_RUNBOOK_PATH}}`（若有）。

## 常用命令

| 操作 | 命令 |
|---|---|
{{DEV_COMMAND_ROWS}}

## 质量门

| 门 | 命令 | 何时跑 |
|---|---|---|
| 文档 / Notes / skill 壳 | `{{GATE_COMMAND}}` | 改站岗文档、Notes、postmortem、`.agents/skills`、发现壳后 |
| 业务单测 / 集成 / e2e | 见上表与 [{{PRE_PUSH_SKILL}}](../.agents/skills/{{PRE_PUSH_SKILL}}/SKILL.md) | 按 **diff** 选跑，勿无脑全量 |

**纪律：** `{{GATE_COMMAND}}` **不**默认并入业务 `test` 目标。声称通过前须列出本 diff 实跑命令与结果。

实现：`scripts/agent-gates/run-all.sh`（Makefile 目标见同目录 `Makefile.snippet`）。

## Notes / Skills

- Notes 合约：[`.agents/notes/README.md`](../.agents/notes/README.md)
- 归档 skill：`{{ARCHIVE_SKILL}}`
- Skill 真源在 `.agents/skills/`；Claude/Cursor 仅发现壳
