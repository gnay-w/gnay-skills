#!/usr/bin/env bash
# Ensure every .agents/skills/* has thin discovery shells in .claude and .cursor.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
AGENTS_SKILLS="${ROOT}/.agents/skills"
fail=0
MAX_SHELL_LINES=40

if [[ ! -d "$AGENTS_SKILLS" ]]; then
  echo "ERROR: missing $AGENTS_SKILLS" >&2
  exit 1
fi

while IFS= read -r -d '' skill_md; do
  name=$(basename "$(dirname "$skill_md")")
  for tool in .claude/skills .cursor/skills; do
    shell="${ROOT}/${tool}/${name}/SKILL.md"
    if [[ ! -f "$shell" ]]; then
      echo "ERROR: missing discovery shell: ${tool}/${name}/SKILL.md (canonical .agents/skills/${name})" >&2
      fail=1
      continue
    fi
    if ! grep -qF ".agents/skills/${name}/SKILL.md" "$shell"; then
      echo "ERROR: ${tool}/${name}/SKILL.md must point to .agents/skills/${name}/SKILL.md" >&2
      fail=1
    fi
    lines=$(wc -l <"$shell" | tr -d ' ')
    if (( lines > MAX_SHELL_LINES )); then
      echo "ERROR: ${tool}/${name}/SKILL.md has ${lines} lines (max ${MAX_SHELL_LINES}); keep shells thin" >&2
      fail=1
    fi
  done
done < <(find "$AGENTS_SKILLS" -mindepth 2 -maxdepth 2 -name SKILL.md -print0 | sort -z)

# No orphan tool shells without canonical
for tool in .claude/skills .cursor/skills; do
  [[ -d "${ROOT}/${tool}" ]] || continue
  while IFS= read -r -d '' shell; do
    name=$(basename "$(dirname "$shell")")
    if [[ ! -f "${AGENTS_SKILLS}/${name}/SKILL.md" ]]; then
      echo "ERROR: orphan shell ${tool}/${name} has no .agents/skills/${name}/SKILL.md" >&2
      fail=1
    fi
  done < <(find "${ROOT}/${tool}" -mindepth 2 -maxdepth 2 -name SKILL.md -print0 2>/dev/null)
done

if [[ $fail -eq 0 ]]; then
  echo "ok: skill discovery shells match .agents/skills"
fi
exit "$fail"
