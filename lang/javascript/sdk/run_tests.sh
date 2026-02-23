#!/usr/bin/env bash
# Bazel sh_test wrapper: install deps and run jest.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
npm ci --silent
exec npm test
