# Testing Standards — End-to-End Tests

E2E tests exercise the full stack: `ldk dev` starts the server, and the `lws` CLI is invoked via `typer.testing.CliRunner` to perform operations. This tests the complete production code path.

For common rules (AAA pattern, variable naming, magic string extraction), see [COMMON.md](COMMON.md).

## File Naming and Placement

```
tests/e2e/<service>/test_<cli_command>.py
```

One file per CLI command. Example:

```
tests/e2e/dynamodb/test_put_item.py
tests/e2e/s3api/test_get_object.py
tests/e2e/ssm/test_put_parameter.py
```

## Fixtures

The E2E `conftest.py` provides these session-scoped fixtures:

| Fixture | Purpose | Error on failure |
|---------|---------|-----------------|
| `e2e_port` | The port `ldk dev` is listening on | — |
| `lws_invoke(args)` | Run an `lws` CLI command in the **Arrange** phase | `RuntimeError("Arrange failed ...")` |
| `assert_invoke(args)` | Run an `lws` CLI command in the **Assert** phase | `AssertionError("Assert failed ...")` |
| `tmp_path` | Pytest built-in for temporary files | — |

### `lws_invoke` vs `assert_invoke`

Both invoke the `lws` CLI and return stdout on success. The difference is the error type on failure:

- **`lws_invoke`** — use in the **Arrange** phase. Failure raises `RuntimeError` so it's clear the setup failed, not the test.
- **`assert_invoke`** — use in the **Assert** phase. Failure raises `AssertionError` so it's clear the verification failed.

Never use `lws_invoke` in the Assert phase or `assert_invoke` in the Arrange phase.

## Template

```python
import json
from typer.testing import CliRunner
from lws.cli.lws import app

runner = CliRunner()


class TestPutParameter:
    def test_put_parameter(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        param_name = "/e2e/put-param-test"
        expected_value = "test-value"

        # Act
        result = runner.invoke(app, [
            "ssm", "put-parameter",
            "--name", param_name,
            "--value", expected_value,
            "--type", "String",
            "--port", str(e2e_port),
        ])

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["ssm", "get-parameter", "--name", param_name,
                                 "--port", str(e2e_port)])
        actual_value = json.loads(verify)["Parameter"]["Value"]
        assert actual_value == expected_value
```

## Assertion Requirements

1. **Always assert exit code first**: `assert result.exit_code == 0, result.output`
2. **Verify the action completed** by reading back the resource (e.g., `get-item` after `put-item`, `list-queues` after `create-queue`).
3. **Use `assert_invoke`** (not `lws_invoke`) for verification calls so failures report as `"Assert failed"`.
4. **Use `lws_invoke`** only in the Arrange phase for setup steps.
5. **For delete operations**, verify the resource is absent from the corresponding list command.

## Resource Naming

Every test must use **unique resource names** so tests never collide when running in parallel or in any order.

```python
# GOOD — unique, descriptive names
table_name = "e2e-put-item"
param_name = "/e2e/get-param-test"
bucket_name = "e2e-list-objects"

# BAD — generic names that could collide
table_name = "test-table"
param_name = "/param"
bucket_name = "bucket"
```

Name pattern: `e2e-<operation>` or `/e2e/<operation>`.

## Common Patterns

### Create + verify

```python
def test_create_queue(self, e2e_port, lws_invoke, assert_invoke):
    # Arrange
    queue_name = "e2e-create-queue"

    # Act
    result = runner.invoke(app, [
        "sqs", "create-queue",
        "--queue-name", queue_name,
        "--port", str(e2e_port),
    ])

    # Assert
    assert result.exit_code == 0, result.output
    verify = assert_invoke(["sqs", "list-queues", "--port", str(e2e_port)])
    assert queue_name in verify
```

### Write + read back

```python
def test_put_object(self, e2e_port, tmp_path, lws_invoke, assert_invoke):
    # Arrange
    bucket_name = "e2e-put-obj"
    key = "file.txt"
    expected_content = "upload content"
    lws_invoke(["s3api", "create-bucket", "--bucket", bucket_name, "--port", str(e2e_port)])
    body_file = tmp_path / "upload.txt"
    body_file.write_text(expected_content)

    # Act
    result = runner.invoke(app, [
        "s3api", "put-object",
        "--bucket", bucket_name,
        "--key", key,
        "--body", str(body_file),
        "--port", str(e2e_port),
    ])

    # Assert
    assert result.exit_code == 0, result.output
    outfile = tmp_path / "verify.txt"
    verify_result = runner.invoke(app, [
        "s3api", "get-object",
        "--bucket", bucket_name,
        "--key", key,
        str(outfile),
        "--port", str(e2e_port),
    ])
    assert verify_result.exit_code == 0, verify_result.output
    actual_content = outfile.read_text()
    assert actual_content == expected_content
```

### Delete + verify absent

```python
def test_delete_parameter(self, e2e_port, lws_invoke, assert_invoke):
    # Arrange
    param_name = "/e2e/del-param"
    lws_invoke(["ssm", "put-parameter", "--name", param_name,
                 "--value", "v", "--type", "String", "--port", str(e2e_port)])

    # Act
    result = runner.invoke(app, [
        "ssm", "delete-parameter",
        "--name", param_name,
        "--port", str(e2e_port),
    ])

    # Assert
    assert result.exit_code == 0, result.output
    verify = assert_invoke(["ssm", "describe-parameters", "--port", str(e2e_port)])
    assert param_name not in verify
```
