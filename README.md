# gnay-skills

Personal / shared Agent Skills bag ([GitHub](https://github.com/gnay-w/gnay-skills)).  
Each top-level directory is **one skill** (or one vendored skill tree). Do not dump loose `SKILL.md` files at repo root.

## Contents

| Directory | Role |
|---|---|
| [`scaffolding-repo-skills/`](scaffolding-repo-skills/) | Meta skill: explain Janus-style skill system **or** scaffold into a product repo (copy templates → explore → fill). |
| [`acceptance-console-http/`](acceptance-console-http/) | Vendored skill — **copy as-is** into product `.agents/skills/` (not generated from a blank template). |

Not included (product-specific): `ops-runbook`, `deploy-prod`.

## Install for local discovery

Symlink into your agent skills path (adjust if you use `~/.claude/skills` only):

```bash
mkdir -p ~/.agents/skills
ln -sfn "$(pwd)/scaffolding-repo-skills" ~/.agents/skills/scaffolding-repo-skills
# optional: also expose acceptance as a readable source; product repos should copy it in-tree
ln -sfn "$(pwd)/acceptance-console-http" ~/.agents/skills/acceptance-console-http
```

Re-open the agent session (or refresh skills) after linking.

## Scaffolding workflow (summary)

1. Read `scaffolding-repo-skills/SKILL.md` (modes: explain | scaffold).
2. On scaffold: copy `templates/<shape-id>/` (or whole `acceptance-console-http/`) into the **target product repo**, add Claude/Cursor shells from `references/shell-template.md`.
3. Explore the target repo; replace `{{PLACEHOLDER}}`s.
4. Suggest a root `AGENTS.md` Skills table row (see `references/agents-skills-section.md`).

Shape IDs: `agent-notes`, `doc-standards`, `archive-agent-notes`, `code-review`, `pre-push-checks`, `acceptance-console-http`.

## Adding another skill to this bag

1. Create `gnay-skills/<skill-name>/SKILL.md` (and optional `references/`, `scripts/`).
2. Do not nest under `scaffolding-repo-skills/` unless it is part of that meta skill.
3. Update this README table.
4. Commit and push.
