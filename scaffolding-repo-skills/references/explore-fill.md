# Explore → fill map

After shapes are on disk (**new:** copied skeletons; **legacy:** patches/migrations), read the **target** repo and replace placeholders. Never copy another product’s domain iron rules into placeholders unchanged.
## Universal

| Placeholder | Explore source |
|---|---|
| `{{REPO_NAME}}` / `{{REPO_ONE_LINER}}` | target identity |
| `{{SKILL_DIR}}` | on-disk skill folder name |
| `{{AGENT_NOTES_SKILL}}` `{{ARCHIVE_SKILL}}` `{{DOC_STANDARDS_SKILL}}` `{{PRE_PUSH_SKILL}}` `{{CODE_REVIEW_SKILL}}` | chosen suite dir names (must match) |
| `{{GATE_COMMAND}}` | `make agent-gates` or `bash scripts/agent-gates/run-all.sh` |
| `{{SPECS_PATH}}` | specs/plans tree if any |
| `{{TECH_DEBT_PATH}}` | tech-debt doc if any |
| `{{OPS_RUNBOOK_PATH}}` | ops runbook if any |
| `{{WORD_BUDGET_ROOT}}` / `{{WORD_BUDGET_DOCS_AGENTS}}` | default 1600 / 1200 unless target says otherwise |

## System

| Placeholder | Explore source |
|---|---|
| `{{DOC_MAP_EXTRA_ROWS}}` | existing docs map |
| `{{RUN_TABLE_ROWS}}` / `{{DEV_COMMAND_ROWS}}` | Makefile / README / CI |
| `{{DOMAIN_IRON_RULE_SECTIONS}}` | target standing summaries only |
| `{{CALIBRATION_*}}` | target decision pairs for notes split/merge examples |
| `{{INCIDENT_GATE_ROWS}}` | existing postmortems / empty table OK |
| `{{SKILLS_TABLE_ROWS}}` | installed skills → truth sources |
| forbidden-paths.manifest | paths the target bans as second authorities |

## Skills

| Placeholder | Explore source |
|---|---|
| `{{DOMAIN_CHECK_BULLETS}}` | target iron-law / layering / defensive docs → **阻塞要求** |
| `{{SEMANTICS_BULLETS}}` | semantics gates/tests miss → **手工检查** |
| `{{AUTHORITY_LINKS_EXTRA}}` | standing docs (defensive patterns, testing, package AGENTS, …) |
| `{{GATE_MATRIX_EXTRA_ROWS}}` | backend/frontend/e2e commands by path |
| `{{KEEP_EXAMPLES}}` / `{{ARCHIVE_EXAMPLES}}` / `{{REJECTED_EXAMPLES}}` | target notes corpus or generic placeholders left listed in report |
