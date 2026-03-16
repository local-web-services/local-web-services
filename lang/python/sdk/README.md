# local-web-services-python-sdk

Python testing SDK for [local-web-services](https://local-web-services.github.io) — starts
in-process AWS service emulators and provides pre-configured `boto3` clients that point at them.
Your production code works unchanged: the SDK sets `AWS_ENDPOINT_URL_*` environment variables
that boto3 picks up automatically.

## Installation

```bash
pip install local-web-services-python-sdk
# or
uv add local-web-services-python-sdk
```

Requires Python 3.9+ and `boto3`.

## Quick start

```python
from lws_testing import LwsSession, DynamoTable, SqsQueue, S3Bucket

with LwsSession(
    DynamoTable("Orders", hash_key="id"),
    SqsQueue("OrderQueue"),
    S3Bucket("my-bucket"),
) as session:
    # Get a boto3 client pointing at the local emulator
    dynamo = session.client("dynamodb")
    dynamo.put_item(TableName="Orders", Item={"id": {"S": "1"}, "status": {"S": "pending"}})

    item = dynamo.get_item(TableName="Orders", Key={"id": {"S": "1"}})
    assert item["Item"]["status"]["S"] == "pending"

    # SQS
    sqs = session.client("sqs")
    queue_url = session.queue_url("OrderQueue")
    sqs.send_message(QueueUrl=queue_url, MessageBody="hello")

    # S3
    s3 = session.client("s3")
    s3.put_object(Bucket="my-bucket", Key="file.txt", Body=b"hello")
```

## Auto-discover resources from CDK / Terraform

```python
# Read resource definitions from a CDK project
with LwsSession.from_cdk("../my-cdk-project") as session:
    dynamo = session.client("dynamodb")
    ...

# Read resource definitions from a Terraform project
with LwsSession.from_hcl("../my-terraform-project") as session:
    s3 = session.client("s3")
    ...
```

## Resource specs

Declare the resources your test needs up front so LwsSession creates them before the test runs:

| Spec | Description |
|---|---|
| `DynamoTable(name, hash_key, sort_key=None)` | PAY_PER_REQUEST DynamoDB table |
| `SqsQueue(name)` | Standard SQS queue |
| `S3Bucket(name)` | S3 bucket |
| `SnsTopic(name)` | SNS topic |
| `SsmParameter(name, value, type="String")` | SSM Parameter Store entry |
| `Secret(name, value)` | Secrets Manager secret |
| `StateMachine(name, definition)` | Step Functions state machine |

## pytest integration

The package registers pytest fixtures automatically via the `pytest11` entry point.
Add a session fixture to your `conftest.py`:

```python
# conftest.py
import pytest
from lws_testing import DynamoTable, SqsQueue

@pytest.fixture(scope="session")
def lws_session_spec():
    return [
        DynamoTable("Orders", hash_key="id"),
        SqsQueue("OrderQueue"),
    ]
```

Then use the `lws_session` fixture in your tests:

```python
def test_create_order(lws_session):
    client = lws_session.client("dynamodb")
    client.put_item(TableName="Orders", Item={"id": {"S": "42"}})
    item = client.get_item(TableName="Orders", Key={"id": {"S": "42"}})
    assert item["Item"]["id"]["S"] == "42"
```

## Supported services

All 20 services are available via `session.client(service_name)`:

| Service | `session.client(...)` name |
|---|---|
| DynamoDB | `"dynamodb"` |
| SQS | `"sqs"` |
| S3 | `"s3"` |
| SNS | `"sns"` |
| EventBridge | `"events"` |
| Step Functions | `"stepfunctions"` |
| Cognito IDP | `"cognito-idp"` |
| Lambda | `"lambda"` |
| API Gateway | `"apigateway"` |
| RDS | `"rds"` |
| DocumentDB | `"docdb"` |
| SSM Parameter Store | `"ssm"` |
| Secrets Manager | `"secretsmanager"` |
| ElastiCache | `"elasticache"` |
| Neptune | `"neptune"` |
| MemoryDB | `"memorydb"` |
| Glacier | `"glacier"` |
| Elasticsearch | `"es"` |
| OpenSearch | `"opensearch"` |
| S3 Tables | `"s3tables"` |

## How it works

`LwsSession` picks a random free base port and starts each service emulator in a background
thread within the test process. It sets `AWS_ENDPOINT_URL_<SERVICE>` (and stub credentials) in
the current process environment so that any boto3 client created during the test automatically
talks to the local emulator. On `__exit__` the servers are stopped and the environment is restored.

## License

MIT
