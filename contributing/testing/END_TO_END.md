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

## No Skipped Tests

All E2E tests must run in every environment — local development and CI. **Tests must never be skipped.**

- Feature files must not use `@skip`, `@wip`, or `@xfail` tags
- Test files must not use `@pytest.mark.skip` or `@pytest.mark.skipif` decorators
- If a test requires an external dependency (e.g. Docker, a container image), CI must be configured to provide it rather than skipping the test
- The `test_no_skipped_tests` architecture test enforces this policy

When adding a new dependency:
1. Add the required setup step to `.github/workflows/ci.yml` in the `test-e2e` job
2. Document the local requirement in this file

## `@internal` — Scenarios Requiring Internal API Control

Some scenarios describe system states that the public AWS API cannot create.
These are permanently excluded from the standard test run using the `@internal`
tag.

**Use `@internal` when and only when** the scenario requires an internal or
private API to force the system into a state that no sequence of public API
calls can produce. Examples:

- A resource is in `DELETING` state (AWS transitions this internally; there is
  no public API call that puts a resource into `DELETING` and leaves it there)
- A capacity limit is reached (`no item slot is available`, `no execution slot
  is available`) — the fake has no public API to exhaust capacity
- A resource is `PENDING_DELETION` with a recovery window still open

```gherkin
@dynamodb @delete_table @controlplane
Feature: DynamoDB DeleteTable

  @happy
  Scenario: Delete an existing table
    ...

  @error @internal
  Scenario: Reject deletion when table is already DELETING
    Given the table is already "DELETING"
    When I delete table "e2e-delete-table"
    Then the command will fail with "ResourceInUseException"
```

The BDD runner in each language filters `not @internal` so these scenarios
are excluded before they reach the step runner. They are not "not yet
implemented" — they describe behaviour that is genuinely untestable without
internal control of the fake.

**Do not use `@internal` for:**

- Scenarios whose behaviour is not yet implemented in a particular language's
  fake. Those must be implemented — not tagged or skipped.
- Scenarios that require Docker or other external dependencies. Configure CI
  to provide those dependencies instead.

## Tags Produced by `tools/fizz_to_gherkin.py`

When feature files are generated from a FizzBee spec, the script applies a
fixed set of tags. Never add or remove these tags by hand — regenerate the
file instead.

### Feature-level tags

Every generated feature file begins with two tags on the `Feature:` line:

| Tag | Meaning |
|-----|---------|
| `@<service>` | Service name in lowercase (e.g. `@dynamodb`, `@s3api`). Derived from `--service` or the spec filename. |
| `@generated` | Marks the feature file as auto-generated from a FizzBee spec. |

### Scenario-level tags

Each scenario receives a combination of tags drawn from three groups.

#### Test-type tag — what kind of test this scenario is

| Tag | Meaning |
|-----|---------|
| `@minimal` | One happy-path scenario per action. |
| `@guard` | One scenario per guard violation — the action is attempted with a precondition deliberately broken. |
| `@sequence` | A chain of two or three actions exercising state transitions. |
| `@invariant` | A standalone check for a stub safety assertion. |

#### Outcome tag — what the scenario asserts

| Tag | Paired with | Meaning |
|-----|-------------|---------|
| `@happy` | `@minimal` | The action succeeds with all preconditions met. |
| `@negative` | `@guard` | The action is rejected because a guard condition is violated. |

#### Action tag — which FizzBee action the scenario covers

`@minimal` and `@guard` scenarios also carry a tag derived from the action
name (CamelCase → `snake_case`):

```gherkin
@minimal @happy @create_table
Scenario: Create a table

@guard @negative @create_table
Scenario: Create a table fails when the table already exists
```

`@sequence` scenarios cover multiple actions and do not carry an action tag.

#### Skip tags — scenarios that require privileged state

These tags appear on `@guard` scenarios when the guard violation cannot be
reproduced through public API calls alone:

| Tag | Source annotation | Meaning |
|-----|-------------------|---------|
| `@lifecycle` | `# guard_violation_lifecycle:` | Requires internal lifecycle control to reach this state. |
| `@capacity` | `# guard_violation_capacity:` | Requires internal capacity control (e.g. slot exhaustion). |
| `@<custom>` | `# fake_skip:` on the action | Action-level skip tag; applies to all of that action's scenarios. |

`@lifecycle` and `@capacity` are the generated equivalents of `@internal` in
hand-written feature files. All three are permanently excluded from the
standard test run. The pytest `addopts` in each `pyproject.toml` must
filter all three: `-m 'not internal and not lifecycle and not capacity'`.
