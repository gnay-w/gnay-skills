---
name: scaffolding-repo-skills
description: >
  Use when explaining or auditing a Janus-style repo skill system; when scaffolding
  the standing system (AGENTS, notes contract, postmortem, agent-gates); when adding
  skills (agent-notes, doc-standards, archive-agent-notes, code-review, pre-push-checks);
  when running scaffold-suite for a full install; when copying acceptance-console-http;
  or when wiring discovery shells. Do not use for ops-runbook or deploy-prod.
---

# Scaffolding repo skills

Modes: **explain** (no writes) | **scaffold** (copy → explore → fill).

Scaffold kinds:

| Kind | When |
|---|---|
| `scaffold-system` | Greenfield or missing Notes/AGENTS/gates layout |
| `scaffold-skill` | One shape into a repo that already has (or just got) system |
| `scaffold-suite` | System + five generative skills + shells (+ optional acceptance) |

Iron order for every scaffold kind: **copy templates to disk first → explore target → fill `{{PLACEHOLDER}}`**. Never author long skills from scratch before copy.

Does **not** produce `ops-runbook` or `deploy-prod`. `acceptance-console-http` = vendored copy only.

## Mode selection

| Signal | Mode / kind |
|---|---|
| How does this work / audit | **explain** |
| 「整套装上」「scaffold-suite」 | **scaffold-suite** |
| Missing notes/AGENTS/gates only | **scaffold-system** |
| Add one skill | **scaffold-skill** (if system deps missing → run system first or abort with list) |
| Unclear | Ask once |

## Shared rules

1. Canonical body: `.agents/skills/<name>/SKILL.md`. Shells: `.claude/skills/` + `.cursor/skills/` (≤40 lines) → canonical path.
2. description = Use when… only (no workflow summary).
3. One fact, one home — handbooks outside skills; skills link.
4. Root AGENTS Skills table: skill → truth source ([references/agents-skills-section.md](references/agents-skills-section.md)).
5. Shape IDs and deps: [references/shapes.md](references/shapes.md), [references/dependencies.md](references/dependencies.md).
6. Placeholder ← explore map: [references/explore-fill.md](references/explore-fill.md).

## Mode explain

Cover: shape menu, system package, dependency graph, AGENTS principles, audit checklist (dual source, shells, description leak, missing notes contract under agent-notes). No file writes.

## scaffold-system

**Goal:** standing mechanism, not business skills.

1. Target repo path (not `gnay-skills` unless user says so).
2. Copy `templates/system/` into target:

| Template | Destination |
|---|---|
| `AGENTS.md.stub` | merge into root `AGENTS.md` or create if missing (prefer merge Skills + how-we-work stubs) |
| `docs-AGENTS.md.stub` | `docs/AGENTS.md` |
| `notes-README.md` | `.agents/notes/README.md` |
| `notes-skeletons/*.md` | keep under bag for reference **or** copy to `.agents/notes/_skeletons/` (optional) |
| `postmortem-README.md.stub` | `docs/postmortem/README.md` |
| `postmortem-TEMPLATE.md` | `docs/postmortem/TEMPLATE.md` |
| `scripts/agent-gates/*` | `scripts/agent-gates/` |
| create empty dirs | `.agents/notes/{proposed,implemented,rejected,archived}/.gitkeep` (or class dirs on first note) |
| create | `.agents/skills/`, `.claude/skills/`, `.cursor/skills/` |

3. Explore: existing AGENTS, Makefile, repo name, preferred gate invoke (`make agent-gates` vs `bash scripts/agent-gates/run-all.sh`).
4. Fill all `{{…}}` in copied system files (see explore-fill.md).
5. Wire Makefile target if Makefile exists and user agrees; else print suggested snippet.
6. Report paths + remaining placeholders.

## scaffold-skill

1. Check [dependencies.md](references/dependencies.md). If required system files missing → offer `scaffold-system` first; do not leave orphan agent-notes without notes README.
2. Pick shape ID; set `{{SKILL_DIR}}` (often `{repo}-agent-notes` or plain trunk name).
3. Copy `templates/<shape-id>/SKILL.md` → `.agents/skills/{{SKILL_DIR}}/`; shells from `references/shell-template.md`.
4. For `acceptance-console-http`: copy bag `acceptance-console-http/` whole tree; then shells.
5. Explore + fill per shapes.md / explore-fill.md.
6. Print AGENTS Skills row; edit file only if asked.
7. Run `scripts/agent-gates/verify-skill-shells.sh` if present.

## scaffold-suite

Runs in order:

1. `scaffold-system`
2. For each generative shape (`agent-notes`, `doc-standards`, `archive-agent-notes`, `code-review`, `pre-push-checks`): `scaffold-skill` with consistent `{{SKILL_PREFIX}}` (e.g. `janus-` or empty) so cross-links match
3. Ask whether to copy `acceptance-console-http`
4. Fill cross-skill placeholders so sibling names agree
5. Suggest full AGENTS Skills table
6. Run `scripts/agent-gates/run-all.sh` if scripts installed

## Naming

- Shape ID ≈ Janus trunk without requiring prefix (`agent-notes`).
- On-disk dir = `{{SKILL_PREFIX}}{{shape}}` or user override.
- `acceptance-console-http` keeps exact name.

## Anti-patterns

- Long SKILL before template copy
- Handbook pasted into SKILL
- Thick IDE shells
- ops-runbook / deploy-prod via this skill
- Rewriting acceptance instead of copying
- agent-notes without `.agents/notes/README.md`
- Description that narrates procedure
- Claiming suite done while `{{PLACEHOLDER}}` remain

## References

- [shapes.md](references/shapes.md)
- [dependencies.md](references/dependencies.md)
- [explore-fill.md](references/explore-fill.md)
- [shell-template.md](references/shell-template.md)
- [agents-skills-section.md](references/agents-skills-section.md)
- `templates/system/` — standing mechanism
- `templates/<shape-id>/` — skill skeletons
- `../acceptance-console-http/` — vendored copy
