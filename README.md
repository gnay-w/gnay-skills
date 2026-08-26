# gnay-skills

Personal / shared Agent Skills bag ([GitHub](https://github.com/gnay-w/gnay-skills)).  
Each top-level directory is **one skill** (or one vendored skill tree). Do not dump loose `SKILL.md` files at repo root.

## Contents

| Directory | Role |
|---|---|
| [`scaffolding-repo-skills/`](scaffolding-repo-skills/) | Meta skill: **explain** or **scaffold** (`scaffold-system` / `scaffold-skill` / `scaffold-suite`). Copy templates → explore → fill. |
| [`acceptance-console-http/`](acceptance-console-http/) | Vendored skill — copy as-is into product `.agents/skills/`. |

Not included (product-specific): `ops-runbook`, `deploy-prod`.

### What `scaffolding-repo-skills` ships

- **Skill shapes:** `agent-notes`, `doc-standards`, `archive-agent-notes`, `code-review`, `pre-push-checks`
- **System package** (`templates/system/`): root AGENTS stub, `docs/AGENTS.md`, notes README + skeletons, postmortem stubs, portable `scripts/agent-gates/` (shells, note format/class, doc budgets)
- **References:** shapes, dependencies, explore→fill map, shell template, AGENTS Skills section

## Install for local discovery

```bash
mkdir -p ~/.agents/skills
ln -sfn "$(pwd)/scaffolding-repo-skills" ~/.agents/skills/scaffolding-repo-skills
ln -sfn "$(pwd)/acceptance-console-http" ~/.agents/skills/acceptance-console-http
```

## Typical use

- **整套：** “用 scaffolding-repo-skills 对 `<repo>` 跑 scaffold-suite”
- **只要体制：** `scaffold-system`
- **单 skill：** `scaffold-skill` + shape id（缺 notes 合约会先要求 system）
- **验收 skill：** 复制 `acceptance-console-http`

## Adding another skill to this bag

1. Create `gnay-skills/<skill-name>/SKILL.md` (+ optional refs/scripts).
2. Do not nest under `scaffolding-repo-skills/` unless it belongs to that meta skill.
3. Update this README table.
4. Commit and push.
