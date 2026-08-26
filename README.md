# gnay-skills

Shared Agent Skills bag ([GitHub](https://github.com/gnay-w/gnay-skills)).  
One top-level directory per skill (or vendored tree). No loose `SKILL.md` at repo root.

## Contents

| Directory | Role |
|---|---|
| [`scaffolding-repo-skills/`](scaffolding-repo-skills/) | Meta skill: explain or scaffold (`system` / `skill` / `suite`). **新项目骨架生成 / 老项目改造**；templates = shared flow/logic + placeholders. No product brand inside templates. |
| [`acceptance-console-http/`](acceptance-console-http/) | Vendored acceptance skill — copy into product `.agents/skills/` as-is. |

### System package (`templates/system/`)

- Root `AGENTS.md` + `docs/AGENTS.md` + `docs/development.md` (structure/flow)
- Notes contract + **4×6** tree script (`create-notes-tree.sh`)
- Postmortem README/TEMPLATE
- Portable `scripts/agent-gates/` (budgets, note format/class, forbidden paths, doc links, skill shells)

### Workflow skill templates

`agent-notes` · `doc-standards` · `archive-agent-notes` · `code-review` · `pre-push-checks`

## Install

```bash
mkdir -p ~/.agents/skills
ln -sfn "$(pwd)/scaffolding-repo-skills" ~/.agents/skills/scaffolding-repo-skills
ln -sfn "$(pwd)/acceptance-console-http" ~/.agents/skills/acceptance-console-http
```

## Use

- Full: scaffold-suite（先判新/老）  
- Layout only: scaffold-system  
- One skill: scaffold-skill + shape id  
- Acceptance: copy `acceptance-console-http/`  

新仓：按模板建齐。老仓：先审计再增量改造，禁止整文件铲平有效站岗文。