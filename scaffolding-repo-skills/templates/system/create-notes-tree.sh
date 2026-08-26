#!/usr/bin/env bash
# Create .agents/notes dual-axis directories (4 lifecycle × 6 class) — same logic as reference repos.
set -euo pipefail
ROOT="${1:-.}"
NOTES="$ROOT/.agents/notes"
for life in proposed implemented rejected archived; do
  for class in architecture process feature bug-fix simplification testing; do
    mkdir -p "$NOTES/$life/$class"
    touch "$NOTES/$life/$class/.gitkeep"
  done
done
echo "ok: created notes 4×6 tree under $NOTES"
