#!/usr/bin/env bash
# Fail if listed markdown files exceed word-count budgets.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
MANIFEST="${ROOT}/scripts/agent-gates/doc-budgets.manifest"
fail=0
while read -r path max || [[ -n "${path:-}" ]]; do
  [[ -z "${path:-}" || "$path" =~ ^# ]] && continue
  f="${ROOT}/${path}"
  if [[ ! -f "$f" ]]; then
    echo "ERROR: budget target missing: $path" >&2
    fail=1
    continue
  fi
  words=$(wc -w <"$f" | tr -d ' ')
  if (( words > max )); then
    echo "ERROR: $path has ${words} words (max ${max})" >&2
    fail=1
  else
    echo "ok: $path ${words}/${max} words"
  fi
done <"$MANIFEST"
exit "$fail"
