# Shape catalog (Janus-aligned IDs)

| Shape ID | Janus counterpart | Template / source |
|---|---|---|
| `agent-notes` | `janus-agent-notes` | `templates/agent-notes/` |
| `doc-standards` | `janus-doc-standards` | `templates/doc-standards/` |
| `archive-agent-notes` | `janus-archive-agent-notes` | `templates/archive-agent-notes/` |
| `code-review` | `janus-code-review` | `templates/code-review/` |
| `pre-push-checks` | `janus-pre-push-checks` | `templates/pre-push-checks/` |
| `acceptance-console-http` | same name | bag root `acceptance-console-http/` (copy tree) |

Not in catalog: `ops-runbook`, `deploy-prod`.

Every generative scaffold also installs discovery shells from `shell-template.md`.

---

## agent-notes

**Use when:** decision locked / rejected / writing specs with new tradeoffs; proactive, user need not ask.

**Copy:** `templates/agent-notes/SKILL.md` → `.agents/skills/{{SKILL_DIR}}/` + shells.

**Explore:** notes README (when to write, lifecycle, skeleton); archive skill if present; root AGENTS “how we work” bullet on Notes.

**Fill:** triggers, notes path layout, class enum, gate command, sibling skill names, forbid list aligned to repo.

---

## doc-standards

**Use when:** writing/editing standing docs, maps, Note prose/placement — not the decision-lock moment (defer to agent-notes).

**Copy:** `templates/doc-standards/` + shells.

**Explore:** `docs/AGENTS.md` or equivalent; root AGENTS map; word budgets; maintenance obligation table; postmortem location.

**Fill:** placement table, budgets, maintenance rows, link to agent-notes / archive skills, gate command.

---

## archive-agent-notes

**Use when:** supersession on new Note; archive/prune rejected; keep-vs-archive by future value.

**Copy:** `templates/archive-agent-notes/` + shells.

**Explore:** notes README lifecycle rules; gate command; 1–2 repo-specific keep/archive calibration examples if available.

**Fill:** path rules, classification bullets, report format, link to pre-push-checks.

---

## code-review

**Use when:** reviewing PR or local changeset.

**Copy:** `templates/code-review/` + shells.

**Explore:** standing iron-law docs; Notes/postmortem rules; what automated gates already catch.

**Fill:** authority links; blocking checklist items (repo-specific); output sections. Prefer “gates already catch → mention gate, don’t essay”.

---

## pre-push-checks

**Use when:** before push or before claiming checks passed.

**Copy:** `templates/pre-push-checks/` + shells.

**Explore:** Makefile / package scripts / `docs/development.md`; whether doc gates are separate from unit tests.

**Fill:** diff→command matrix; claim report template; link related skills.

---

## acceptance-console-http

**Use when:** product work done and pushed; user asks 验收 / ensure_project / create_job / ACCEPT_*.

**Copy:** entire `gnay-skills/acceptance-console-http/` → `TARGET/.agents/skills/acceptance-console-http/` (keep `SKILL.md` + `reference-http.md`). Then shells with matching description from that SKILL frontmatter.

**Explore:** target `repo_url`, baseline branch, AGENTS acceptance blurb — update only repo-specific constants in AGENTS index / example section if the vendored SKILL has a per-repo example block; prefer minimal edits.

**Do not** invent a new api-playbook shape.
