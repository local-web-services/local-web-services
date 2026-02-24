#!/usr/bin/env bash
# Bazel sh_test wrapper: run tests via the Gradle wrapper (handles JUnit 5).
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
exec ./gradlew test
