# Session Context

**Session ID:** 0cfd2a28-e8a9-48e2-ac27-b5abe9ba4430

**Commit Message:** I want to only keep the gherkin style tests

## Prompt

I want to only keep the gherkin style tests

## Summary

`make check` passes. Here's what was changed to enforce Gherkin-only E2E tests:

**Architecture tests updated:**
- `test_aaa_comments.py` — removed `tests/e2e` from scan (AAA only applies to unit/integration now)
- `test_no_magic_strings_in_assertions.py` — same, removed `tests/e2e` from scan
- `test_one_class_per_file.py` (E2E) — **deleted** (irrelevant for BDD)
- `test_resource_naming.py` — now scans all `*.py` files including `conftest.py` (resource names moved there)
- **New: `test_bdd_pattern.py`** — enforces that every E2E `test_*.py` uses `scenarios()`, has no `Test*` classes, and references an existing `.feature` file

**Docs updated:**
- `CLAUDE.md` — E2E tests now require Gherkin feature files, not AAA
- `contributing/testing/COMMON.md` — AAA section scoped to unit/integration only, checklist updated
- `contributing/testing/END_TO_END.md` — already documented BDD pattern (from earlier)

## Key Actions

- - **Bash**: Check for remaining old-style test classes
- - **Bash**: Find test files not using BDD scenarios
- - **Bash**: Check for remaining AAA comments in E2E
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/architecture/tests/test_aaa_comments.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/architecture/tests/test_no_magic_strings_in_assertions.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/architecture/tests/e2e/test_one_class_per_file.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/architecture/tests/e2e/test_no_httpx_imports.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/architecture/tests/e2e/test_resource_naming.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/contributing/testing/COMMON.md
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/architecture/tests/test_aaa_comments.py
