# Testing Standards — Unit Tests

Unit tests verify a single function, class, or module in isolation. No CLI, HTTP, or server involved.

For common rules (AAA pattern, variable naming, magic string extraction), see [COMMON.md](COMMON.md).

## File Naming and Placement

```
tests/unit/<module>/test_<source_module_or_area>.py
```

Example: testing `src/lws/providers/dynamodb/provider.py` produces:

```
tests/unit/providers/test_dynamodb_provider_scan.py
tests/unit/providers/test_dynamodb_provider_batch_operations.py
```

The test file name should reflect the source module and the specific area being tested. One test file per logical area — not one giant file per source module.

## Template

```python
import pytest
from lws.providers.dynamodb.provider import SqliteDynamoProvider


class TestScan:
    async def test_scan_returns_all(self, provider):
        # Arrange
        expected_count = 2
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1"})
        await provider.put_item("orders", {"orderId": "o2", "itemId": "i2"})

        # Act
        results = await provider.scan("orders")

        # Assert
        assert len(results) == expected_count

    async def test_scan_with_filter(self, provider):
        # Arrange
        expected_status = "active"
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "status": expected_status})
        await provider.put_item("orders", {"orderId": "o2", "itemId": "i2", "status": "inactive"})

        # Act
        results = await provider.scan(
            "orders",
            filter_expression="status = :s",
            expression_values={":s": expected_status},
        )

        # Assert
        assert len(results) == 1
        actual_status = results[0]["status"]
        assert actual_status == expected_status
```

## Guidelines

### Fixtures

- Use pytest fixtures for provider setup/teardown. Define them at the top of the file or in a local `conftest.py`.
- Fixtures should create, start, yield, and stop the provider:

```python
@pytest.fixture
async def provider(tmp_path):
    p = SqliteDynamoProvider(data_dir=tmp_path, tables=[table_config()])
    await p.start()
    yield p
    await p.stop()
```

### Test class grouping

- Group related tests in a class (e.g., `TestScan`, `TestPutItem`, `TestDeleteItem`).
- The class name should describe the operation or area being tested.

### Async tests

- Provider methods are `async`. Use `async def test_*` methods.
- pytest-asyncio handles the event loop automatically.

### What to test

- Every public method of the class under test.
- Edge cases: empty inputs, missing keys, duplicate entries, boundary values.
- Error cases: invalid inputs should raise the expected exceptions.

### What NOT to test

- Private methods (prefixed with `_`) — test them through public methods.
- Third-party library behaviour — assume it works.
- Implementation details that could change without affecting behaviour.
