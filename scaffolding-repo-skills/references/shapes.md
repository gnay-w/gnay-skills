# Shape catalog (Janus-aligned IDs)

| Shape ID | Janus counterpart | Template / source | System dep |
|---|---|---|---|
| _(system)_ | standing layout | `templates/system/` | — |
| `agent-notes` | `janus-agent-notes` | `templates/agent-notes/` | notes README |
| `doc-standards` | `janus-doc-standards` | `templates/doc-standards/` | `docs/AGENTS.md` |
| `archive-agent-notes` | `janus-archive-agent-notes` | `templates/archive-agent-notes/` | notes README |
| `code-review` | `janus-code-review` | `templates/code-review/` | root AGENTS |
| `pre-push-checks` | `janus-pre-push-checks` | `templates/pre-push-checks/` | gates/docs |
| `acceptance-console-http` | same | bag `acceptance-console-http/` | none |

Not in catalog: `ops-runbook`, `deploy-prod`.

See also: [dependencies.md](dependencies.md), [explore-fill.md](explore-fill.md).

---

## system (not a skill shape)

**Copy** `templates/system/` per SKILL `scaffold-system` table.  
**Explore/fill** AGENTS stubs, notes README skill links, budgets, Makefile snippet.  
**Create** `.agents/notes/{proposed,implemented,rejected,archived}/`, `.agents/skills/`, `.claude/skills/`, `.cursor/skills/`.

---

## agent-notes

**Use when:** decision locked / rejected / writing specs with new tradeoffs; proactive.

**Copy:** template + shells. **Requires:** `.agents/notes/README.md`.

**Explore:** notes README; archive/doc-standards sibling dirs; root AGENTS how-we-work.

**Fill:** triggers, path pattern, gate command, sibling names, forbid list. See explore-fill.md.

---

## doc-standards

**Use when:** writing/editing standing docs — not decision-lock (defer to agent-notes).

**Copy:** template + shells. **Requires:** `docs/AGENTS.md` (install via system if missing).

**Explore:** placement/maintenance/budgets; agent-notes skill name.

**Fill:** placement rows, budgets, maintenance, postmortem rule, gate command.

---

## archive-agent-notes

**Use when:** supersession / archive / prune rejected.

**Copy:** template + shells. **Requires:** notes README.

**Explore:** lifecycle rules; 1–2 keep/archive examples from repo notes if any.

**Fill:** classification, examples, gate, pre-push link.

---

## code-review

**Use when:** reviewing PR or local changeset.

**Copy:** template + shells.

**Explore:** standing iron-law docs; what gates already catch.

**Fill:** authority links; domain blocking checks; semantics bullets; output stays four-tier.

---

## pre-push-checks

**Use when:** before push or claiming checks passed.

**Copy:** template + shells.

**Explore:** Makefile / development doc / CI.

**Fill:** gate matrix; claim report; sibling skill links.

---

## acceptance-console-http

**Copy:** entire bag `acceptance-console-http/` → `.agents/skills/acceptance-console-http/` + shells.  
**Do not** regenerate as a blank api-playbook.
