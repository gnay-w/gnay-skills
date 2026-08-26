# Root AGENTS.md — Skills section & writing principles

## Writing principles（真源在 `docs/AGENTS.md`）

Scaffold **must** install/merge `docs/AGENTS.md` with: placement table, one-fact-one-home, word budgets, Note/postmortem when-to, maintenance obligations, placement bans, and a **「根 AGENTS.md 书写原则」** section.

Root `AGENTS.md` **must** include a **文档地图** table whose first/primary row links to `docs/AGENTS.md` as writing principles. A single prose sentence “see docs/AGENTS” without a map row is **not** enough.

## Per-session root AGENTS

- Short iron rules, how-we-work, doc map, skill index — not full domain tutorials.
- Domain detail = **summary + link** to `docs/*.md`.
- Native prose; no “ported from …” framing.
- Specs/plans = task history, not current behavioral authority.

## Skills subsection

```markdown
## Skills

Skill **正文真源**一律在 `.agents/skills/`。`.claude/skills/` 与 `.cursor/skills/` 只放**发现壳**；改流程只改 `.agents/skills/`。

| Skill（`.agents/skills/…`） | 文档/脚本真源 |
|---|---|
| `{{SKILL_DIR}}` | {{TRUTH_SOURCE_PATH_OR_DOC}} |
```
