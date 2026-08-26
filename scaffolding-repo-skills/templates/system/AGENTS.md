# {{REPO_NAME}} — AGENTS.md

{{REPO_ONE_LINER}}

本文件只写本仓站岗铁律与「以后怎么工作」。通用个人规范见 agent 运行时配置。文档分层与**维护义务**见 [`docs/AGENTS.md`](docs/AGENTS.md)。

## 以后怎么工作

1. 读本文件铁律 → 相关 [`docs/`](docs/) 专篇 → 搜 [`.agents/notes/`](.agents/notes/README.md)
2. **非琐碎决策 agent 主动写/更新 Agent Note**（不跟是否开头脑风暴；未建成→`proposed`，已落地→`implemented`，否决→`rejected`；机械改动豁免，见 notes README）；行为/契约变了按 [`docs/AGENTS.md`](docs/AGENTS.md)「维护义务」同步专篇/runbook/债/路线图/产品文档
3. **系统性翻车 agent 主动写** [`docs/postmortem/`](docs/postmortem/README.md) + 更新事故→门表（见 testing 专篇若有）
4. 提交前：`{{GATE_COMMAND}}`；按需业务测试 / e2e（见 [`docs/development.md`](docs/development.md)）
5. 功能怎么做：`{{SPECS_PATH}}`；为什么/否决：Notes

## 文档地图

| 文档 | 用途 |
|---|---|
| [`docs/AGENTS.md`](docs/AGENTS.md) | **书写原则**：分层、一事实一家、词数预算、维护义务 |
| [`docs/development.md`](docs/development.md) | 本地命令与质量门 |
| [`docs/postmortem/`](docs/postmortem/README.md) | 事故 → 护栏 |
| [`.agents/notes/`](.agents/notes/README.md) | 决策记忆 |
| `{{SPECS_PATH}}` | specs / plans（不做站岗长文） |
{{DOC_MAP_EXTRA_ROWS}}

## 跑起来（高频）

| 操作 | 命令 |
|---|---|
{{RUN_TABLE_ROWS}}

全文命令表见 [`docs/development.md`](docs/development.md)。

## 域铁律摘要

<!-- 探索目标仓后填写：每域短摘要 + 链专篇；禁止把专篇全文搬进本文件。 -->

{{DOMAIN_IRON_RULE_SECTIONS}}

## 质量门

- `{{GATE_COMMAND}}`：文档预算、Note 格式、禁止路径、站岗链接、skill 发现壳（**不**并入默认业务 `test` 目标，除非本仓明确合并）
- 说明：[`docs/development.md`](docs/development.md)

## Skills

Skill **正文真源**一律在 [`.agents/skills/`](.agents/skills/)。`.claude/skills/` 与 `.cursor/skills/` 只放**发现壳**（同名目录，指向真源）；改流程只改 `.agents/skills/`。

| Skill（`.agents/skills/…`） | 文档/脚本真源 |
|---|---|
{{SKILLS_TABLE_ROWS}}
