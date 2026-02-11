# Testing Standards — Integration Tests

Integration tests verify multiple modules working together via the API layer. They issue HTTP requests against the in-process FastAPI app without starting the full `ldk dev` server.

For common rules (AAA pattern, variable naming, magic string extraction), see [COMMON.md](COMMON.md).

## File Naming and Placement

```
tests/integration/test_<service>_<operation_or_area>.py
```

Example:

```
tests/integration/test_dynamodb_create_table.py
tests/integration/test_s3_put_object.py
tests/integration/test_sqs_send_receive.py
```

## Template

```python
import json
import pytest
from httpx import AsyncClient


class TestDynamoDbCreateTable:
    async def test_create_table(self, client: AsyncClient, port: int):
        # Arrange
        table_name = "int-test-table"
        expected_status = "ACTIVE"

        # Act
        response = await client.post(
            f"http://localhost:{port}/",
            headers={"X-Amz-Target": "DynamoDB_20120810.CreateTable"},
            json={
                "TableName": table_name,
                "KeySchema": [{"AttributeName": "pk", "KeyType": "HASH"}],
                "AttributeDefinitions": [{"AttributeName": "pk", "AttributeType": "S"}],
            },
        )

        # Assert
        expected_status_code = 200
        assert response.status_code == expected_status_code
        actual_status = response.json()["TableDescription"]["TableStatus"]
        assert actual_status == expected_status
```

## Guidelines

### Scope

Integration tests sit between unit tests and E2E tests:

- **Do** test the HTTP routing, request parsing, and provider response format.
- **Do** test that multiple modules integrate correctly (e.g., API routing to provider to storage).
- **Do not** start `ldk dev` — use the FastAPI `TestClient` or `httpx.AsyncClient` directly.
- **Do not** use the `lws` CLI — that belongs in E2E tests.

### Fixtures

- Use a session or module-scoped fixture to create the FastAPI app and start providers.
- Use `httpx.AsyncClient` for making requests.

### What to test

- Correct HTTP status codes for success and error cases.
- Response body structure matches the AWS API format.
- Request validation rejects malformed payloads.
- Multiple operations in sequence (e.g., create then describe, put then get).

### Wire protocols

Different services use different wire protocols. Match the real AWS format:

| Service | Protocol | Header |
|---------|----------|--------|
| DynamoDB | JSON body | `X-Amz-Target: DynamoDB_20120810.<Action>` |
| SQS | Form-encoded or JSON | `X-Amz-Target: AmazonSQS.<Action>` |
| SNS | JSON body | `X-Amz-Target: AmazonSimpleNotificationService.<Action>` |
| S3 | REST (PUT/GET/DELETE) | Path-based: `/<bucket>/<key>` |
| Step Functions | JSON body | `X-Amz-Target: AWSStepFunctions.<Action>` |
| EventBridge | JSON body | `X-Amz-Target: AWSEvents.<Action>` |
| Cognito | JSON body | `X-Amz-Target: AWSCognitoIdentityProviderService.<Action>` |
| SSM | JSON body | `X-Amz-Target: AmazonSSM.<Action>` |
| Secrets Manager | JSON body | `X-Amz-Target: secretsmanager.<Action>` |
