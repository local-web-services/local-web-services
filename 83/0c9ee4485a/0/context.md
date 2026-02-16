# Session Context

**Session ID:** 0cfd2a28-e8a9-48e2-ac27-b5abe9ba4430

**Commit Message:** There are lots of e2e test files with little content. eg """E2E tests fo

## Prompt

there are lots of e2e test files with little content. eg """E2E tests for apigateway delete-integration."""

from pytest_bdd import scenarios

scenarios("features/delete_integration.feature")
. this seems like too much effort

## Summary

All 2240 tests pass. Here's what changed:

**Removed ~195 thin wiring files** (`test_<command>.py`) across all 20 services, replaced each service with a single `test_scenarios.py`:

```python
"""E2E scenarios — all feature files are loaded automatically by pytest-bdd."""

from pytest_bdd import scenarios

scenarios("features/")
```

**Architecture tests updated:**
- `test_cli_command_test_coverage.py` — now checks for `.feature` files instead of `test_*.py` files
- `test_bdd_pattern.py` — simplified to check for `scenarios()`, no `Test*` classes, and `features/` directory per service
- `test_one_class_per_file.py` (E2E) — already deleted earlier

**Docs updated** to reflect the single-file approach.

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/architecture/tests/test_cli_command_test_coverage.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/architecture/tests/test_cli_command_test_coverage.py
- - **Bash**: Count test files per service to remove
- - **Bash**: Replace all thin wiring files with single test_scenarios.py per service
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/architecture/tests/e2e/test_bdd_pattern.py
- - **Write**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/architecture/tests/e2e/test_bdd_pattern.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/contributing/testing/END_TO_END.md
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/contributing/testing/END_TO_END.md
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/contributing/testing/END_TO_END.md
- - **Bash**: Run make check after consolidating test files
