---
name: scaffolding-repo-skills
description: >
  Use when explaining or auditing a Janus-style repo skill system; when adding a
  skill (agent-notes, doc-standards, archive-agent-notes, code-review,
  pre-push-checks) to a product repo; when copying acceptance-console-http; or
  when wiring .agents/skills plus Claude/Cursor discovery shells. Do not use for
  Janus-only ops-runbook or deploy-prod playbooks.
---

# Scaffolding repo skills

Single skill, two modes: **explain** (no file writes) and **scaffold** (copy templates → explore repo → fill placeholders).

Does **not** produce `ops-runbook` or `deploy-prod` shapes (project-specific). `acceptance-console-http` is **vendored copy only**.

## Mode selection

| Signal | Mode |
|---|---|
| User wants files added / shells / copy acceptance | **scaffold** |
| User asks how the system works, audits existing skills, picks a shape | **explain** |
| Unclear | Ask once: explain only, or scaffold now? |

## Shared rules (both modes)

1. **Canonical body** lives in `.agents/skills/<name>/SKILL.md` only. `.claude/skills/` and `.cursor/skills/` are discovery shells (≤40 lines) that point at the canonical path.
2. **description** = Use when… (triggers/symptoms). Never summarize the workflow in the description.
3. **One fact, one home** — handbooks/runbooks stay outside the skill; skills link them.
4. Root **AGENTS.md** Skills section: short layout rule + table row `skill → truth source` (see [references/agents-skills-section.md](references/agents-skills-section.md)).
5. Shape IDs align with Janus names (minus optional `janus-` prefix): see [references/shapes.md](references/shapes.md).

## Mode explain

1. Show the shape menu in `shapes.md`.
2. Walk AGENTS writing principles (standing rules short; map + links; maintenance obligations; native prose).
3. Audit checklist for an existing skill:
   - Body duplicated in IDE shells?
   - Shell missing or missing canonical path?
   - Description leaks procedure?
   - Handbook pasted into SKILL instead of linked?

Do not write files in explain mode.

## Mode scaffold

**Iron order: copy templates first → explore project → enrich. Do not author a full skill from scratch before templates are on disk.**

### Steps

1. **Target repo** — path from user. Do **not** write into `gnay-skills` unless they explicitly want a bag-local skill.
2. **Greenfield** — if `.agents/skills/` missing: ask whether to create the minimal layout first; on yes, create dirs + optional AGENTS Skills stub from `references/agents-skills-section.md`.
3. **Pick shape ID** from `shapes.md` (or `acceptance-console-http`).
4. **Copy templates**
   - Generative shapes: copy `templates/<shape-id>/SKILL.md` → `TARGET/.agents/skills/{{SKILL_DIR}}/SKILL.md`
   - Always copy [references/shell-template.md](references/shell-template.md) into both:
     - `TARGET/.claude/skills/{{SKILL_DIR}}/SKILL.md`
     - `TARGET/.cursor/skills/{{SKILL_DIR}}/SKILL.md`
   - `acceptance-console-http`: copy whole directory from this bag’s `acceptance-console-http/` (includes `reference-http.md`); then add shells. Do not rewrite it into a new “api-playbook”.
5. **Explore** the target (read what exists):
   - Root `AGENTS.md`, `docs/AGENTS.md` if any
   - Notes/contracts README paths
   - `docs/development.md` / Makefile / test commands
   - Domain standing docs for review checklist
   - Existing `.agents/skills/*`
6. **Fill** every `{{PLACEHOLDER}}` in the copied SKILL (and shells: `{{SKILL_DIR}}`, `{{DESCRIPTION}}`). Use exploration facts; leave a short “still empty” list if something cannot be inferred.
7. **AGENTS index** — print a suggested Skills table row; edit the file only if the user asks.
8. **Report** — paths created/updated; placeholders filled vs remaining; remind shell-symmetry gate if the repo has one.

### Naming

- Shape ID = Janus trunk without requiring `janus-` (e.g. `agent-notes`).
- On-disk dir `{{SKILL_DIR}}` = user choice, often `{repo}-agent-notes` or plain `agent-notes`.
- `acceptance-console-http` keeps that exact directory name.

## Anti-patterns

- Writing a long SKILL before copying the template
- Pasting full handbooks into SKILL.md
- Thick copies under `.claude` / `.cursor`
- Scaffolding ops-runbook or deploy-prod via this skill
- Regenerating acceptance instead of copying the vendored tree
- Description that narrates the procedure

## References

- [shapes.md](references/shapes.md) — per-shape copy/explore/fill
- [shell-template.md](references/shell-template.md)
- [agents-skills-section.md](references/agents-skills-section.md)
- `templates/<shape-id>/` — generative skeletons
- `../acceptance-console-http/` — vendored copy source
