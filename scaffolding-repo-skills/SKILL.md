---
name: scaffolding-repo-skills
description: >
  Use when explaining or auditing a repo skill/doc/notes system; when scaffolding
  standing layout (AGENTS, notes dual-axis tree, postmortem, agent-gates); when
  adding skills (agent-notes, doc-standards, archive-agent-notes, code-review,
  pre-push-checks); when running scaffold-suite; when copying acceptance-console-http;
  or when wiring discovery shells. Templates encode shared flow/logic only — no
  product-branded content.
---

# Scaffolding repo skills

Modes: **explain** (no writes) | **scaffold** (copy templates → explore target → fill `{{PLACEHOLDER}}`).

Scaffold kinds: `scaffold-system` | `scaffold-skill` | `scaffold-suite`.

**Iron order:** copy templates first → explore → fill. Never paste a product repo’s standing docs into the bag as “templates”.

Templates must stay **brand-free**: same section flow and rules as the reference system; domain facts only via placeholders filled from the **target** repo.

## Mode selection

| Signal | Mode / kind |
|---|---|
| How it works / audit | **explain** |
| Full install | **scaffold-suite** |
| Layout only (AGENTS/notes/gates) | **scaffold-system** |
| One skill | **scaffold-skill** (run system first if deps missing) |
| Unclear | Ask once |

## Shared rules

1. Canonical skill body: `.agents/skills/<name>/SKILL.md`. Shells: `.claude` + `.cursor` (≤40 lines) → canonical path; shell `description` **copied from** canonical frontmatter.
2. description = Use when… only (no workflow summary in description).
3. One fact, one home.
4. Notes dual-axis: `{lifecycle}/{class}/yyyy-mm-dd-topic.md` with **full 4×6 tree** (`create-notes-tree.sh`).
5. Docs gates ≠ default business `test`.
6. See [dependencies.md](references/dependencies.md), [explore-fill.md](references/explore-fill.md), [shapes.md](references/shapes.md).

## Mode explain

Cover system package, skill shapes, dependency graph, AGENTS principles, notes dual-axis, audit checklist. No writes.

## scaffold-system

Copy `templates/system/` into target:

| Template | Destination |
|---|---|
| `AGENTS.md` | merge or create root `AGENTS.md` |
| `docs-AGENTS.md` | `docs/AGENTS.md` |
| `notes-README.md` | `.agents/notes/README.md` |
| `create-notes-tree.sh` | run against target (creates 4×6 + `.gitkeep`) |
| `postmortem-README.md` / `postmortem-TEMPLATE.md` | `docs/postmortem/` |
| `development.md` | `docs/development.md`（合并已有则保留目标仓命令、补门纪律） |
| `scripts/agent-gates/*` | `scripts/agent-gates/` |
| dirs | `.agents/skills/`, `.claude/skills/`, `.cursor/skills/` |

Then explore → fill placeholders (no product names left in templates). Wire Makefile via `Makefile.snippet` if asked.

## scaffold-skill

1. Check dependencies; missing notes README / 4×6 → system first.
2. Copy `templates/<shape-id>/SKILL.md` → `.agents/skills/{{SKILL_DIR}}/`.
3. Shells from `references/shell-template.md` with **same description** as canonical.
4. `acceptance-console-http`: copy bag vendored tree only (not regenerated).
5. Explore → fill; print AGENTS Skills row; run `verify-skill-shells.sh` if present.

## scaffold-suite

1. `scaffold-system`
2. Five generative skills with consistent `{{SKILL_DIR}}` / cross-links
3. Optional acceptance copy
4. Fill cross-skill names; suggest Skills table; run `run-all.sh`

## Anti-patterns

- Copying a product repo’s AGENTS/domain iron rules into this bag
- Leaving product brand strings inside templates
- Long SKILL before template copy
- Thick IDE shells / handbook pasted into SKILL
- agent-notes without notes README + 4×6 tree
- Claiming done while `{{PLACEHOLDER}}` remain
