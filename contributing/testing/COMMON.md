# Testing Standards — Common Rules

This document defines the testing conventions shared across all test levels (unit, integration, E2E). It is intended for both human contributors and AI agents.

## Test Levels

Every new feature must include tests at the appropriate levels:

| Level | Directory | Scope | Runner |
|-------|-----------|-------|--------|
| **Unit** | `tests/unit/` | Single function, class, or module in isolation | `make test` |
| **Integration** | `tests/integration/` | Multiple modules working together via the API layer | `make test` |
| **E2E** | `tests/e2e/` | Full stack via `ldk dev` and the `lws` CLI | `make test-e2e` |

### When to write each level

- **Unit tests** — required for all new code. One test file per source module or logical area.
- **Integration tests** — required when the feature involves API routing, request parsing, or provider orchestration.
- **E2E tests** — required for every new `lws` CLI command. One test file per CLI command.

## Test Structure — Arrange / Act / Assert (Unit and Integration Only)

Unit and integration tests must follow the **Arrange / Act / Assert** (AAA) pattern with explicit section comments. E2E tests use Gherkin / pytest-bdd instead — see [END_TO_END.md](END_TO_END.md).

```python
def test_example(self):
    # Arrange
    expected_value = "hello"

    # Act
    actual_value = do_something()

    # Assert
    assert actual_value == expected_value
```

### Rules

1. Every test method must have `# Arrange`, `# Act`, and `# Assert` comments.
2. If a section is empty (e.g., no arrange needed), the comment is still required with a `pass` or a brief note.
3. The `# Act` section should contain exactly one operation — the thing being tested.
4. The `# Assert` section contains only assertions, not additional logic.

## Variable Naming

### Strings and values in assertions

If a string, number, or value appears in an `assert` statement, it must be stored in a variable.

```python
# BAD — magic string in assert
assert result["status"] == "active"

# GOOD — extracted to variable
expected_status = "active"
actual_status = result["status"]
assert actual_status == expected_status
```

### Strings used more than once

If a string is used more than once in a test method, it must be stored in a variable.

```python
# BAD — repeated string
provider.put_item("orders", {"orderId": "o1"})
result = provider.get_item("orders", {"orderId": "o1"})

# GOOD — stored in variable
table_name = "orders"
key = {"orderId": "o1"}
provider.put_item(table_name, key)
result = provider.get_item(table_name, key)
```

### Naming conventions

| Location | Prefix | Example |
|----------|--------|---------|
| Arrange phase — values you expect to see later | `expected_` | `expected_status = "active"` |
| Assert phase — values extracted from results | `actual_` | `actual_status = result["status"]` |
| Resource identifiers used across phases | descriptive name | `table_name = "orders"` |
| Single-use strings NOT in assertions | no extraction needed | `provider.delete("temp")` |

### Exceptions — do not force it

- Boolean assertions: `assert result is True` is fine — no need for `expected_flag = True`.
- None checks: `assert result is None` is fine.
- Length checks: `assert len(items) == 2` is fine when the count is obvious from context. Extract to `expected_count` only when the number is not immediately clear.
- Checking key presence: `assert "key" in result` is fine when the key name is self-documenting.

## Running Tests

```bash
# All unit and integration tests
make test

# E2E tests (starts ldk dev automatically)
make test-e2e

# Single service
uv run pytest tests/e2e/ssm/ -v

# Single file
uv run pytest tests/e2e/ssm/test_put_parameter.py -v

# All checks (lint, format, complexity, tests)
make check
```

## Checklist for New Features

Before submitting a pull request, verify:

- [ ] Unit tests cover every new public function or method
- [ ] Integration tests cover any new API routing or request handling
- [ ] E2E tests cover every new `lws` CLI command (one feature file + wiring file per command)
- [ ] Unit and integration tests follow the Arrange / Act / Assert pattern with section comments
- [ ] E2E tests use Gherkin / pytest-bdd (see [END_TO_END.md](END_TO_END.md))
- [ ] No magic strings in assertions — all extracted to `expected_*` / `actual_*` variables
- [ ] No repeated strings — all stored in named variables
- [ ] Resource names in E2E tests are unique and descriptive
- [ ] `make check` passes
- [ ] `make test-e2e` passes
