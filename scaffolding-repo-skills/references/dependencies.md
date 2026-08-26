# Dependencies

| Install | Requires on disk first |
|---|---|
| `scaffold-system` | nothing (creates layout) |
| `agent-notes` | `.agents/notes/README.md`; prefer `archive-agent-notes` sibling (or same suite) |
| `archive-agent-notes` | `.agents/notes/README.md` |
| `doc-standards` | `docs/AGENTS.md` (or create via system); link to agent-notes skill once present |
| `code-review` | root `AGENTS.md`; Notes/postmortem rules if those suites exist |
| `pre-push-checks` | some gate/test commands discoverable (Makefile/docs); `scripts/agent-gates/` if using doc/skill gates |
| `acceptance-console-http` | none from this system (external console); product work done + pushed at **use** time |
| `scaffold-suite` | empty or partial repo OK — system runs first |

**Orphan rule:** never leave `*-agent-notes` skill pointing at a missing notes README. If user refuses system install, abort skill install with the missing path list.

**Cross-link rule:** within one suite, fill `{{AGENT_NOTES_SKILL}}`, `{{ARCHIVE_SKILL}}`, `{{DOC_STANDARDS_SKILL}}`, `{{PRE_PUSH_SKILL}}` to the **same** on-disk dir names chosen for that suite.
