# Shape catalog (workflow skills)

Shape IDs name **portable skill roles** (same jobs/flow as the reference system). They are not product brand names.

| Shape ID | Role | Template |
|---|---|---|
| _(system)_ | AGENTS / notes dual-axis / postmortem / gates | `templates/system/` |
| `agent-notes` | Decision-lock thin trigger | `templates/agent-notes/` |
| `doc-standards` | Doc map / budgets / maintenance entry | `templates/doc-standards/` |
| `archive-agent-notes` | Supersession / archive / prune | `templates/archive-agent-notes/` |
| `code-review` | Orient reviewer: sources → blocking → manual → reporting | `templates/code-review/` |
| `pre-push-checks` | Diff → gate picker | `templates/pre-push-checks/` |
| `acceptance-console-http` | Vendored HTTP acceptance (copy tree) | bag `acceptance-console-http/` |

Not packaged: product-only ops/deploy playbooks.

Every generative skill also installs discovery shells. Notes organization is **not** a skill shape — it is system dual-axis layout (see `notes-README.md` + `create-notes-tree.sh`).
