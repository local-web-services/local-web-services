# Testing Standards — End-to-End Tests

E2E tests exercise the full stack: `ldk dev` starts the server, and the `lws` CLI is invoked via `typer.testing.CliRunner` to perform operations. This tests the complete production code path.

E2E tests use **Gherkin / pytest-bdd** for readability and consistency.

For common rules (variable naming, magic string extraction), see [COMMON.md](COMMON.md).

## File Structure

```
tests/e2e/<service>/
  __init__.py
  conftest.py                    # Step definitions, fixtures, hooks
  test_scenarios.py              # Loads all feature files
  features/                      # Gherkin feature files
    <command>.feature
    ...
```

One feature file per CLI command. A single `test_scenarios.py` loads them all. Step definitions live in `conftest.py`.

## Gherkin Conventions

### Tense

- **Given** — past tense: `a parameter "/e2e/test" was created with value "v" and type "String"`
- **When** — present tense: `I put parameter "/e2e/test" with value "v" and type "String"`
- **Then** — future tense: `the command will succeed`, `parameter "/e2e/test" will have value "v"`

### Tags

Every feature file must include:
- **Service tag**: `@ssm`, `@s3api`, `@dynamodb`, etc.
- **Operation tag**: `@put_parameter`, `@get_object`, etc.
- **Plane tag**: `@dataplane` or `@controlplane`

Each scenario must include:
- **Outcome tag**: `@happy` or `@error`

Example:

```gherkin
@ssm @put_parameter @dataplane
Feature: SSM PutParameter

  @happy
  Scenario: Put a new string parameter
    When I put parameter "/e2e/put-param-test" with value "test-value" and type "String"
    Then the command will succeed
    And parameter "/e2e/put-param-test" will have value "test-value"
```

## Wiring File

Each service has a single `test_scenarios.py` that loads all feature files:

```python
"""E2E scenarios — all feature files are loaded automatically by pytest-bdd."""

from pytest_bdd import scenarios

scenarios("features/")
```

The `test_cli_command_test_coverage` architecture test verifies that a `.feature` file exists for every CLI command.

## Step Definitions

Step definitions live in `tests/e2e/<service>/conftest.py` alongside fixtures and hooks. Each `conftest.py` imports `runner` and `app` at module level.

### `conftest.py` pattern

```python
"""Shared fixtures for <service> E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a parameter "{name}" was created with value "{value}" and type "{param_type}"'),
    target_fixture="given_param",
)
def a_parameter_was_created(name, value, param_type, lws_invoke, e2e_port):
    lws_invoke([
        "ssm", "put-parameter",
        "--name", name, "--value", value, "--type", param_type,
        "--port", str(e2e_port),
    ])
    return {"name": name, "value": value}


@when(
    parsers.parse('I put parameter "{name}" with value "{value}" and type "{param_type}"'),
    target_fixture="command_result",
)
def i_put_parameter(name, value, param_type, e2e_port):
    return runner.invoke(app, [
        "ssm", "put-parameter",
        "--name", name, "--value", value, "--type", param_type,
        "--port", str(e2e_port),
    ])


@then(
    parsers.parse('parameter "{name}" will have value "{expected_value}"'),
)
def parameter_will_have_value(name, expected_value, assert_invoke, e2e_port):
    verify = assert_invoke([
        "ssm", "get-parameter", "--name", name, "--port", str(e2e_port),
    ])
    actual_value = verify["Parameter"]["Value"]
    assert actual_value == expected_value
```

### Given steps (Arrange)

Use `lws_invoke` for setup. Use past tense.

### When steps (Act)

Use `runner.invoke` directly. Use present tense. Always set `target_fixture="command_result"`.

### Then steps (Assert)

Use future tense. The shared step `the command will succeed` is defined in `tests/e2e/conftest.py` — do not redefine it per service.

## Fixtures

The E2E `conftest.py` provides these session-scoped fixtures:

| Fixture | Purpose | Error on failure |
|---------|---------|-----------------|
| `e2e_port` | The port `ldk dev` is listening on | — |
| `lws_invoke(args)` | Run an `lws` CLI command in **Given** steps | `RuntimeError("Arrange failed ...")` |
| `assert_invoke(args)` | Run an `lws` CLI command in **Then** steps | `AssertionError("Assert failed ...")` |
| `parse_output(text)` | Parse JSON output from CLI | — |
| `tmp_path` | Pytest built-in for temporary files | — |

### `lws_invoke` vs `assert_invoke`

Both invoke the `lws` CLI and return parsed output on success. The difference is the error type on failure:

- **`lws_invoke`** — use in **Given** steps. Failure raises `RuntimeError`.
- **`assert_invoke`** — use in **Then** steps. Failure raises `AssertionError`.

## Resource Naming

Every test must use **unique resource names** so tests never collide.

```gherkin
# GOOD — unique, descriptive names with e2e prefix
Given a parameter "/e2e/put-param-test" was created ...
When I create table "e2e-query-table" ...

# BAD — generic names that could collide
Given a parameter "/test" was created ...
When I create table "my-table" ...
```

Name pattern: `e2e-<operation>` or `/e2e/<operation>`.
