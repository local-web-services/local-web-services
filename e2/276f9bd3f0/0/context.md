# Session Context

**Session ID:** 7f740c94-9c39-47ea-a878-612782fb9aa0

**Commit Message:** Implement the following plan:

# Plan: Move steps back into conftest.py,

## Prompt

Implement the following plan:

# Plan: Move steps back into conftest.py, remove steps/ directories

## Context

The one-file-per-step migration introduced a `globals()` hack to work around pytest-bdd's fixture injection model. The user wants steps defined directly in conftest.py — simple, IDE-friendly, no hacks needed.

## What to do

For each of the 20 services under `tests/e2e/`:

1. **Merge step code back into conftest.py** — copy step functions (with their `@given`/`@when`/`@then` decorators and imports) from each `steps/*.py` file into the service's `conftest.py`. Add `runner = CliRunner()` and `from lws.cli.lws import app` at the top.

2. **Delete `steps/` directory** — remove the entire `steps/` folder for each service.

3. **Keep special code in lambda_/conftest.py** — Docker checks, `pytest_collection_modifyitems`, handler constants, and fixtures stay; step definitions are added alongside.

4. **Keep special shared state in conftest.py** — SNS helpers (`_extract_topic_arn`, `_topic_arns`, etc.) and StepFunctions constants (`PASS_DEFINITION`, `ROLE_ARN`, etc.) go directly in their service conftest.py.

## Architecture tests to update

**File:** `tests/architecture/tests/e2e/test_bdd_pattern.py`

Remove these tests (they enforce the now-removed steps/ pattern):
- `test_every_service_has_steps_directory`
- `test_no_step_decorators_in_service_conftest`
- `test_conftest_injects_step_fixtures`
- `test_every_step_file_is_explicitly_imported`

Keep these tests:
- `test_e2e_test_files_use_scenarios`
- `test_e2e_test_files_have_no_test_classes`
- `test_every_service_has_features_directory`

## Documentation to update

**File:** `contributing/testing/END_TO_END.md`

Revert to the simpler pattern: step definitions live in `conftest.py`. Remove `steps/` directory references and the `pytest_configure` / fixture injection documentation.

## Files to modify

- `tests/e2e/*/conftest.py` — all 20 services (merge steps back in)
- `tests/e2e/*/steps/` — all 20 directories (delete)
- `tests/architecture/tests/e2e/test_bdd_pattern.py` — remove steps/ enforcement tests
- `tests/architecture/tests/test_file_naming.py` — remove steps/ exemption if present
- `contributing/testing/END_TO_END.md` — simplify docs

## Verification

```bash
make check       # 2244 passed
make test-e2e    # 226 passed, 0 skipped
```


If you need specific details from before exiting plan mode (like exact code snippets, error messages, or content you generated), read the full transcript at: /Users/eamonnfaherty/.REDACTED.jsonl

## Summary

Migration complete. Here's a summary:

**What was done:**
- Merged step definitions from `steps/*.py` back into `conftest.py` for all 20 services
- Deleted all 20 `steps/` directories
- Removed 4 architecture tests from `test_bdd_pattern.py` that enforced the steps/ pattern
- Removed the steps/ exemption from `test_file_naming.py`
- Updated `contributing/testing/END_TO_END.md` to document the simpler conftest.py pattern
- Fixed special cases: lambda_ (subprocess/pytest imports, Docker checks, fixtures), SNS (helper functions, shared dicts), stepfunctions (JSON constants)

**Verification:** `make check` (2240 passed), `make test-e2e` (226 passed)

---

Regarding your Allure Report request — that's a separate feature. Would you like me to plan an implementation for adding Allure Report support to the project? I can look into what's needed (pytest-allure plugin, configuration, CI integration, etc.).

## Key Actions

- - **TaskCreate**: For each service under tests/e2e/, merge step functions from steps/*.py into conftest.py, then delete the steps/ directory.
- - **TaskCreate**: Remove tests that enforce the steps/ pattern from test_bdd_pattern.py and update test_file_naming.py if needed.
- - **TaskCreate**: Revert to the simpler pattern: step definitions live in conftest.py. Remove steps/ directory references.
- - **TaskCreate**: Verify all tests pass after the migration.
- - **TaskUpdate**: 
- - **Bash**: List all e2e service directories
- - **Bash**: List all step files in each service
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/e2e/dynamodb/conftest.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/e2e/dynamodb/steps/__init__.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/tests/e2e/dynamodb/steps/a_table_was_created.py
