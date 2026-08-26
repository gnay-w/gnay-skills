#!/usr/bin/env bash
# Check relative markdown links in standing docs resolve to existing files/dirs.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
fail=0

scan_file() {
  local f="$1"
  local dir
  dir=$(dirname "$f")
  # [text](target) — skip http(s), mailto, pure anchors
  local links
  links=$(grep -oE '\[[^]]*\]\([^)]+\)' "$f" || true)
  [[ -z "$links" ]] && return
  while IFS= read -r link; do
    [[ -z "$link" ]] && continue
    local target
    target=$(sed -E 's/^\[[^]]*\]\((.*)\)$/\1/' <<<"$link")
    # strip title in quotes if any: url "title"
    target=$(sed -E 's/[[:space:]]+".*"$//;s/[[:space:]]+'\''.*'\''$//' <<<"$target")
    [[ "$target" =~ ^https?:// ]] && continue
    [[ "$target" =~ ^mailto: ]] && continue
    [[ "$target" =~ ^# ]] && continue
    # drop fragment
    local path="${target%%#*}"
    [[ -z "$path" ]] && continue
    local resolved
    if [[ "$path" == /* ]]; then
      resolved="${ROOT}${path}"
    else
      resolved="${dir}/${path}"
    fi
    # normalize ..
    resolved=$(cd "$(dirname "$resolved")" 2>/dev/null && echo "$(pwd)/$(basename "$resolved")" || echo "$resolved")
    if [[ ! -e "$resolved" ]]; then
      echo "ERROR: broken link in ${f#"$ROOT"/}: $target" >&2
      fail=1
    fi
  done <<<"$links"
}

# standing surfaces
scan_file "${ROOT}/AGENTS.md"
scan_file "${ROOT}/docs/AGENTS.md"
scan_file "${ROOT}/.agents/notes/README.md"
while IFS= read -r -d '' f; do
  scan_file "$f"
done < <(find "${ROOT}/docs" -maxdepth 1 -name '*.md' -print0)
while IFS= read -r -d '' f; do
  scan_file "$f"
done < <(find "${ROOT}/docs/postmortem" -name '*.md' -print0 2>/dev/null)
while IFS= read -r -d '' f; do
  scan_file "$f"
done < <(find "${ROOT}/.agents/notes" -name '*.md' -print0 2>/dev/null)
while IFS= read -r -d '' f; do
  scan_file "$f"
done < <(find "${ROOT}/.agents/skills" -name '*.md' -print0 2>/dev/null)

if [[ $fail -eq 0 ]]; then
  echo "ok: standing doc links resolve"
fi
exit "$fail"
