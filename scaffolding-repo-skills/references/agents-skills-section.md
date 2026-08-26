# Root AGENTS.md — Skills section (pattern)

## Writing principles

- **Per-session only:** short iron rules, how-we-work, doc map, skill index — not full domain tutorials.
- Domain detail = **summary + link** to `docs/*.md`.
- **One fact, one home**; root vs standing conflict → standing wins, fix root summary.
- Word budgets on root / `docs/AGENTS.md` (default 1600 / 1200) via doc gate.
- Native prose: this repo’s mechanisms; no “ported from …” framing.
- Specs/plans = task history, not current behavioral authority.

## Skills subsection

```markdown
## Skills

Skill **正文真源**一律在 `.agents/skills/`。`.claude/skills/` 与 `.cursor/skills/` 只放**发现壳**；改流程只改 `.agents/skills/`。

| Skill（`.agents/skills/…`） | 文档/脚本真源 |
|---|---|
| `{{SKILL_DIR}}` | {{TRUTH_SOURCE_PATH_OR_DOC}} |
```
