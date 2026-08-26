#!/usr/bin/env bash
# Validate Agent Note class directories against the closed whitelist.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
NOTES="${ROOT}/.agents/notes"
fail=0

ALLOWED='^(architecture|process|feature|bug-fix|simplification|testing)$'

for life in proposed implemented rejected archived; do
  base="${NOTES}/${life}"
  [[ -d "$base" ]] || continue
  # one level of class dirs under lifecycle
  while IFS= read -r -d '' d; do
    name="$(basename "$d")"
    if [[ "$name" == "README.md" ]]; then
      continue
    fi
    if ! [[ "$name" =~ $ALLOWED ]]; then
      echo "ERROR: illegal Agent Note class directory: .agents/notes/${life}/${name} (must be architecture|process|feature|bug-fix|simplification|testing)" >&2
      fail=1
    fi
  done < <(find "$base" -mindepth 1 -maxdepth 1 -type d -print0 2>/dev/null)
done

exit "$fail"
