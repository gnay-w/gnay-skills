# Root AGENTS.md — Skills section (pattern)

When scaffolding or greenfielding, ensure the product repo root `AGENTS.md` eventually contains a short Skills block like this (adapt names/budgets to the repo).

## Writing principles (standing AGENTS)

- **Per-session only:** short iron rules, “how we work”, doc map, skill index — not full domain tutorials.
- Domain detail = **summary + link** to standing docs (`docs/*.md`).
- **One fact, one home**; if root conflicts with a standing doc, fix the standing doc as truth and trim the root summary.
- Optional hard word budget on root / `docs/AGENTS.md` (Janus: 1600 / 1200) enforced by a doc gate if present.
- Native prose: repo mechanisms and paths; no “ported from project X” framing.
- Specs/plans trees are task history, **not** current behavioral authority.

## Skills subsection template

```markdown
## Skills

Skill **正文真源**一律在 `.agents/skills/`。`.claude/skills/` 与 `.cursor/skills/` 只放**发现壳**（同名目录，指向真源）；改流程只改 `.agents/skills/`。

| Skill（`.agents/skills/…`） | 文档/脚本真源 |
|---|---|
| `{{SKILL_DIR}}` | {{TRUTH_SOURCE_PATH_OR_DOC}} |
```

Add one table row per skill. Truth column points at the handbook, script, or “same-dir reference” — not a feature ad.

## Related doc-system pieces (optional greenfield)

| Artifact | Role |
|---|---|
| `docs/AGENTS.md` | Placement table, maintenance obligations, Note/postmortem when-to |
| `.agents/notes/README.md` | Decision-memory contract (if using agent-notes) |
| Doc/shell symmetry gate | e.g. `make agent-gates` including skill-shell verify |
