# local-web-services-testing

Python testing SDK for [local-web-services](https://github.com/local-web-services/local-web-services) — in-process pytest fixtures and boto3 helpers for testing AWS applications without needing a running `ldk dev`.

## Installation

```bash
pip install local-web-services-python-sdk
# or
uv add local-web-services-python-sdk
```

## Quick start

```python
from lws_testing import LwsSession

# Auto-discover resources from a CDK project
with LwsSession.from_cdk("../my-cdk-project") as session:
    dynamo = session.client("dynamodb")
    dynamo.put_item(TableName="Orders", Item={"id": {"S": "1"}})

# Auto-discover resources from a Terraform project
with LwsSession.from_hcl("../my-terraform-project") as session:
    s3 = session.client("s3")
    s3.put_object(Bucket="my-bucket", Key="test.txt", Body=b"hello")

# Explicit resource declaration
with LwsSession(
    tables=[{"name": "Orders", "partition_key": "id"}],
    queues=["OrderQueue"],
    buckets=["ReceiptsBucket"],
) as session:
    table = session.dynamodb("Orders")
    table.put({"id": {"S": "1"}, "status": {"S": "pending"}})
    items = table.scan()
    assert len(items) == 1
```

## pytest integration

The package registers pytest fixtures automatically via the `pytest11` entry point. Add a session fixture to your `conftest.py`:

```python
# conftest.py
import pytest

@pytest.fixture(scope="session")
def lws_session_spec():
    return {
        "tables": [{"name": "Orders", "partition_key": "id"}],
        "queues": ["OrderQueue"],
    }
```

Then use the `lws_session` fixture in your tests:

```python
def test_create_order(lws_session):
    client = lws_session.client("dynamodb")
    client.put_item(TableName="Orders", Item={"id": {"S": "42"}})

    table = lws_session.dynamodb("Orders")
    table.assert_item_exists({"id": {"S": "42"}})
```

## License

MIT
