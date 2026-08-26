#!/usr/bin/env bash
# Fail if listed retired standing paths reappear.
# Edit forbidden-paths.manifest (one relative path per line).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
MANIFEST="${ROOT}/scripts/agent-gates/forbidden-paths.manifest"
fail=0
if [[ ! -f "$MANIFEST" ]]; then
  echo "ok: no forbidden-paths.manifest (skip)"
  exit 0
fi
while read -r p || [[ -n "${p:-}" ]]; do
  [[ -z "${p:-}" || "$p" =~ ^# ]] && continue
  if [[ -e "${ROOT}/${p}" ]]; then
    echo "ERROR: forbidden path exists: $p" >&2
    fail=1
  fi
done <"$MANIFEST"
if [[ $fail -eq 0 ]]; then
  echo "ok: forbidden paths absent"
fi
exit "$fail"
