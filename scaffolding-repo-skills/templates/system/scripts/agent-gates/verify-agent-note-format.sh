#!/usr/bin/env bash
# Validate Agent Note Status vs path and required sections (lifecycle-aware skeleton).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
NOTES="${ROOT}/.agents/notes"
fail=0

check_file() {
  local f="$1"
  local rel="${f#"$ROOT"/}"
  # expected lifecycle from path: .agents/notes/{lifecycle}/...
  local life
  life=$(echo "$rel" | awk -F/ '{print $3}')
  case "$life" in
    proposed|implemented|rejected) ;;
    archived) return 0 ;; # archived: skip format (historical snapshot)
    *) echo "ERROR: unexpected notes path: $rel" >&2; fail=1; return ;;
  esac

  # collect non-empty lines
  mapfile -t lines < <(grep -v '^[[:space:]]*$' "$f" | head -n 20)
  local status_line=""
  local i
  for i in "${!lines[@]}"; do
    if [[ "${lines[$i]}" =~ ^Status:[[:space:]]*(proposed|implemented|rejected)([[:space:]]|—|-|$) ]]; then
      status_line="${lines[$i]}"
      break
    fi
  done
  if [[ -z "$status_line" ]]; then
    # allow Status near second non-empty: lines[1]
    if [[ ${#lines[@]} -ge 2 && "${lines[1]}" =~ ^Status: ]]; then
      status_line="${lines[1]}"
    fi
  fi
  if [[ -z "$status_line" ]]; then
    echo "ERROR: $rel missing Status: proposed|implemented|rejected" >&2
    fail=1
    return
  fi
  local st
  st=$(echo "$status_line" | sed -E 's/^Status:[[:space:]]*//;s/[[:space:]].*//;s/—.*//;s/-$//')
  st="${st%%—*}"
  st=$(echo "$st" | awk '{print $1}')
  if [[ "$st" != "$life" ]]; then
    # rejected allows "Status: rejected — …"
    if ! [[ "$life" == "rejected" && "$status_line" =~ ^Status:[[:space:]]*rejected ]]; then
      echo "ERROR: $rel Status '$st' != lifecycle dir '$life'" >&2
      fail=1
    fi
  fi

  if ! grep -qE '^## Problem' "$f"; then
    echo "ERROR: $rel missing ## Problem" >&2
    fail=1
  fi

  case "$life" in
    proposed)
      if ! grep -qE '^## Proposal' "$f"; then
        echo "ERROR: $rel missing ## Proposal" >&2
        fail=1
      fi
      if ! grep -qE '^## Alternatives considered' "$f"; then
        echo "ERROR: $rel missing ## Alternatives considered" >&2
        fail=1
      fi
      ;;
    implemented)
      for h in '## Decision' '## Alternatives considered' '## Consequences'; do
        if ! grep -qE "^${h}" "$f"; then
          echo "ERROR: $rel missing $h" >&2
          fail=1
        fi
      done
      if grep -qE '^## Proposal' "$f"; then
        echo "ERROR: $rel implemented must not contain ## Proposal" >&2
        fail=1
      fi
      if grep -qE '^## Acceptance criteria' "$f"; then
        echo "ERROR: $rel implemented must not contain ## Acceptance criteria" >&2
        fail=1
      fi
      ;;
    rejected)
      if ! grep -qE '^## Proposal' "$f"; then
        echo "ERROR: $rel missing ## Proposal" >&2
        fail=1
      fi
      if ! grep -qE '^## Alternatives considered' "$f"; then
        echo "ERROR: $rel missing ## Alternatives considered" >&2
        fail=1
      fi
      # rejected: do NOT require Decision / Consequences
      ;;
  esac
}

while IFS= read -r -d '' f; do
  check_file "$f"
done < <(find "$NOTES" \( -path "$NOTES/proposed/*" -o -path "$NOTES/implemented/*" -o -path "$NOTES/rejected/*" \) -name '*.md' -print0 2>/dev/null)

exit "$fail"
