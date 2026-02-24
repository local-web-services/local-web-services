#!/usr/bin/env bash
# Regenerate Bazel requirements.txt files from uv.lock.
# Run this after updating any pyproject.toml / uv.lock.
#
#   ./tools/sync_requirements.sh

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

sync() {
  local dir="$1"
  echo "Syncing $dir/requirements.txt from uv.lock..."
  (cd "$ROOT/$dir" && uv export --no-hashes --no-editable --output-file requirements.txt)
}

sync core
sync lang/python/sdk

echo "Done. Commit the updated requirements.txt files."
