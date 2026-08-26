# Explore → fill map

After templates are copied, read the target repo and replace placeholders. Prefer facts from files over invention. If unknown, leave `{{NAME}}` and list it in the final report.

## Universal

| Placeholder | Explore source |
|---|---|
| `{{REPO_NAME}}` | directory name / go.mod / package.json / AGENTS title |
| `{{SKILL_PREFIX}}` | user choice or existing skill dir prefix (`janus-`, `foo-`, empty) |
| `{{SKILL_DIR}}` | `{{SKILL_PREFIX}}` + shape trunk, or user override |
| `{{GATE_COMMAND}}` | Makefile `agent-gates` target, else `bash scripts/agent-gates/run-all.sh` |
| `{{ROOT_AGENTS_REL}}` | relative path from skill file to root AGENTS.md |
| `{{DESCRIPTION}}` | shape template description after substituting sibling skill names |

## System package

| Placeholder | Explore source |
|---|---|
| `{{HOW_WE_WORK}}` | existing workflow bullets or default from stub |
| `{{DOC_MAP_ROWS}}` | existing docs/ tree |
| `{{WORD_BUDGET_ROOT}}` | default 1600 unless repo says otherwise |
| `{{WORD_BUDGET_DOCS_AGENTS}}` | default 1200 |
| `{{NOTES_SKILL_LINK}}` | path to agent-notes skill once named |
| `{{ARCHIVE_SKILL_LINK}}` | path to archive skill |
| `{{SPECS_PATH}}` | e.g. `docs/superpowers/specs` or `docs/specs` if present |
| `{{TECH_DEBT_PATH}}` | if `docs/tech-debt.md` exists |
| `{{TESTING_DOC}}` | testing standing doc if any (postmortem 事故→门 sync) |

## Skill templates

| Placeholder | Explore source |
|---|---|
| `{{NOTES_README}}` / `{{NOTES_PATH_PATTERN}}` | `.agents/notes/README.md` |
| `{{TRIGGERS_BULLETS}}` | default from Janus-style list; add repo-specific if AGENTS mentions |
| `{{FORBID_BULLETS}}` | notes README「不放进 Note」 |
| `{{PLACEMENT_TABLE_ROWS}}` | `docs/AGENTS.md` placement table |
| `{{MAINTENANCE_TABLE_ROWS}}` | `docs/AGENTS.md` maintenance section |
| `{{GATE_MATRIX_ROWS}}` | Makefile / `docs/development.md` / CI |
| `{{AUTHORITY_LINKS}}` | standing docs linked from root AGENTS |
| `{{DOMAIN_CHECK_*}}` | architecture / isolation / defensive docs (repo-specific) |
| `{{KEEP_EXAMPLES}}` / `{{ARCHIVE_EXAMPLES}}` | existing implemented notes; else generic placeholders |

## Relative links

When filling `*_REL` fields, compute paths from the **written** SKILL.md location (usually `.agents/skills/{{SKILL_DIR}}/SKILL.md`) to the target file. Prefer repo-relative markdown links consistent with existing AGENTS style.
