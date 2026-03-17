"""Integration tests for DynamoDB lifecycle state simulation."""
from __future__ import annotations

import httpx
import pytest

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app

_CREATE_TABLE_HEADERS = {
    "X-Amz-Target": "DynamoDB_20120810.CreateTable",
    "Content-Type": "application/x-amz-json-1.0",
}

_CREATE_TABLE_PAYLOAD = {
    "TableName": "LifecycleTable",
    "KeySchema": [{"AttributeName": "pk", "KeyType": "HASH"}],
    "AttributeDefinitions": [{"AttributeName": "pk", "AttributeType": "S"}],
    "BillingMode": "PAY_PER_REQUEST",
}


@pytest.fixture
async def lifecycle_provider(tmp_path):
    p = SqliteDynamoProvider(data_dir=tmp_path, tables=[])
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def lifecycle_config():
    return ResourceLifecycleConfig(enabled=True, create_dwell_ms=5000, delete_dwell_ms=5000)


@pytest.fixture
def app(lifecycle_provider, lifecycle_config):
    return create_dynamodb_app(lifecycle_provider, lifecycle=lifecycle_config)


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestDynamoDbLifecycleCreating:
    async def test_create_table_returns_creating_status_when_lifecycle_enabled(self, client):
        # Arrange
        expected_status = "CREATING"

        # Act
        resp = await client.post(
            "/",
            json=_CREATE_TABLE_PAYLOAD,
            headers=_CREATE_TABLE_HEADERS,
        )

        # Assert
        assert resp.status_code == 200
        actual_status = resp.json()["TableDescription"]["TableStatus"]
        assert actual_status == expected_status, (
            f"Expected TableStatus '{expected_status}' but got '{actual_status}'"
        )

    async def test_put_item_blocked_when_table_is_creating(self, client):
        # Arrange
        expected_error_type = "ResourceInUseException"
        await client.post("/", json=_CREATE_TABLE_PAYLOAD, headers=_CREATE_TABLE_HEADERS)

        # Act
        put_payload = {
            "TableName": "LifecycleTable",
            "Item": {"pk": {"S": "key1"}},
        }
        resp = await client.post(
            "/",
            json=put_payload,
            headers={**_CREATE_TABLE_HEADERS, "X-Amz-Target": "DynamoDB_20120810.PutItem"},
        )

        # Assert
        actual_error_type = resp.json().get("__type", "")
        assert actual_error_type == expected_error_type, (
            f"Expected error '{expected_error_type}' but got '{actual_error_type}'"
        )

    async def test_get_item_blocked_when_table_is_creating(self, client):
        # Arrange
        expected_error_type = "ResourceInUseException"
        await client.post("/", json=_CREATE_TABLE_PAYLOAD, headers=_CREATE_TABLE_HEADERS)

        # Act
        get_payload = {
            "TableName": "LifecycleTable",
            "Key": {"pk": {"S": "key1"}},
        }
        resp = await client.post(
            "/",
            json=get_payload,
            headers={**_CREATE_TABLE_HEADERS, "X-Amz-Target": "DynamoDB_20120810.GetItem"},
        )

        # Assert
        actual_error_type = resp.json().get("__type", "")
        assert actual_error_type == expected_error_type, (
            f"Expected error '{expected_error_type}' but got '{actual_error_type}'"
        )

    async def test_delete_table_blocked_when_table_is_creating(self, client):
        # Arrange
        expected_error_type = "ResourceInUseException"
        await client.post("/", json=_CREATE_TABLE_PAYLOAD, headers=_CREATE_TABLE_HEADERS)

        # Act
        delete_payload = {"TableName": "LifecycleTable"}
        resp = await client.post(
            "/",
            json=delete_payload,
            headers={**_CREATE_TABLE_HEADERS, "X-Amz-Target": "DynamoDB_20120810.DeleteTable"},
        )

        # Assert
        actual_error_type = resp.json().get("__type", "")
        assert actual_error_type == expected_error_type, (
            f"Expected error '{expected_error_type}' but got '{actual_error_type}'"
        )

    async def test_describe_table_returns_creating_status_while_creating(self, client):
        # Arrange
        expected_status = "CREATING"
        await client.post("/", json=_CREATE_TABLE_PAYLOAD, headers=_CREATE_TABLE_HEADERS)

        # Act
        describe_payload = {"TableName": "LifecycleTable"}
        resp = await client.post(
            "/",
            json=describe_payload,
            headers={**_CREATE_TABLE_HEADERS, "X-Amz-Target": "DynamoDB_20120810.DescribeTable"},
        )

        # Assert
        assert resp.status_code == 200
        actual_status = resp.json()["Table"]["TableStatus"]
        assert actual_status == expected_status, (
            f"Expected TableStatus '{expected_status}' but got '{actual_status}'"
        )

    async def test_query_blocked_when_table_is_creating(self, client):
        # Arrange
        expected_error_type = "ResourceInUseException"
        await client.post("/", json=_CREATE_TABLE_PAYLOAD, headers=_CREATE_TABLE_HEADERS)

        # Act
        query_payload = {
            "TableName": "LifecycleTable",
            "KeyConditionExpression": "pk = :pk",
            "ExpressionAttributeValues": {":pk": {"S": "key1"}},
        }
        resp = await client.post(
            "/",
            json=query_payload,
            headers={**_CREATE_TABLE_HEADERS, "X-Amz-Target": "DynamoDB_20120810.Query"},
        )

        # Assert
        actual_error_type = resp.json().get("__type", "")
        assert actual_error_type == expected_error_type, (
            f"Expected error '{expected_error_type}' but got '{actual_error_type}'"
        )

    async def test_scan_blocked_when_table_is_creating(self, client):
        # Arrange
        expected_error_type = "ResourceInUseException"
        await client.post("/", json=_CREATE_TABLE_PAYLOAD, headers=_CREATE_TABLE_HEADERS)

        # Act
        scan_payload = {"TableName": "LifecycleTable"}
        resp = await client.post(
            "/",
            json=scan_payload,
            headers={**_CREATE_TABLE_HEADERS, "X-Amz-Target": "DynamoDB_20120810.Scan"},
        )

        # Assert
        actual_error_type = resp.json().get("__type", "")
        assert actual_error_type == expected_error_type, (
            f"Expected error '{expected_error_type}' but got '{actual_error_type}'"
        )


@pytest.fixture
async def delete_lifecycle_provider(tmp_path):
    p = SqliteDynamoProvider(data_dir=tmp_path, tables=[])
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def delete_lifecycle_config():
    # No create dwell — table becomes ACTIVE immediately; delete dwell is 5s
    return ResourceLifecycleConfig(enabled=True, create_dwell_ms=0, delete_dwell_ms=5000)


@pytest.fixture
def delete_app(delete_lifecycle_provider, delete_lifecycle_config):
    return create_dynamodb_app(delete_lifecycle_provider, lifecycle=delete_lifecycle_config)


@pytest.fixture
async def delete_client(delete_app):
    transport = httpx.ASGITransport(app=delete_app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestDynamoDbLifecycleDeleting:
    async def test_delete_table_returns_deleting_status_when_lifecycle_enabled(self, delete_client):
        # Arrange
        expected_status = "DELETING"
        await delete_client.post("/", json=_CREATE_TABLE_PAYLOAD, headers=_CREATE_TABLE_HEADERS)

        # Act
        delete_payload = {"TableName": "LifecycleTable"}
        resp = await delete_client.post(
            "/",
            json=delete_payload,
            headers={**_CREATE_TABLE_HEADERS, "X-Amz-Target": "DynamoDB_20120810.DeleteTable"},
        )

        # Assert
        assert resp.status_code == 200
        actual_status = resp.json()["TableDescription"]["TableStatus"]
        assert actual_status == expected_status, (
            f"Expected TableStatus '{expected_status}' but got '{actual_status}'"
        )

    async def test_describe_table_returns_not_found_when_table_is_deleting(self, delete_client):
        # Arrange
        expected_error_type = "ResourceNotFoundException"
        await delete_client.post("/", json=_CREATE_TABLE_PAYLOAD, headers=_CREATE_TABLE_HEADERS)
        delete_payload = {"TableName": "LifecycleTable"}
        await delete_client.post(
            "/",
            json=delete_payload,
            headers={**_CREATE_TABLE_HEADERS, "X-Amz-Target": "DynamoDB_20120810.DeleteTable"},
        )

        # Act
        describe_payload = {"TableName": "LifecycleTable"}
        resp = await delete_client.post(
            "/",
            json=describe_payload,
            headers={**_CREATE_TABLE_HEADERS, "X-Amz-Target": "DynamoDB_20120810.DescribeTable"},
        )

        # Assert
        actual_error_type = resp.json().get("__type", "")
        assert actual_error_type == expected_error_type, (
            f"Expected error '{expected_error_type}' but got '{actual_error_type}'"
        )

    async def test_put_item_blocked_when_table_is_deleting(self, delete_client):
        # Arrange
        expected_error_type = "ResourceNotFoundException"
        await delete_client.post("/", json=_CREATE_TABLE_PAYLOAD, headers=_CREATE_TABLE_HEADERS)
        delete_payload = {"TableName": "LifecycleTable"}
        await delete_client.post(
            "/",
            json=delete_payload,
            headers={**_CREATE_TABLE_HEADERS, "X-Amz-Target": "DynamoDB_20120810.DeleteTable"},
        )

        # Act
        put_payload = {
            "TableName": "LifecycleTable",
            "Item": {"pk": {"S": "key1"}},
        }
        resp = await delete_client.post(
            "/",
            json=put_payload,
            headers={**_CREATE_TABLE_HEADERS, "X-Amz-Target": "DynamoDB_20120810.PutItem"},
        )

        # Assert
        actual_error_type = resp.json().get("__type", "")
        assert actual_error_type == expected_error_type, (
            f"Expected error '{expected_error_type}' but got '{actual_error_type}'"
        )


class TestDynamoDbLifecycleDisabled:
    async def test_create_table_returns_active_when_lifecycle_disabled(self, tmp_path):
        # Arrange
        expected_status = "ACTIVE"
        provider = SqliteDynamoProvider(data_dir=tmp_path, tables=[])
        await provider.start()
        app = create_dynamodb_app(provider)  # no lifecycle config = disabled
        transport = httpx.ASGITransport(app=app)

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            resp = await c.post(
                "/",
                json=_CREATE_TABLE_PAYLOAD,
                headers=_CREATE_TABLE_HEADERS,
            )

        # Assert
        await provider.stop()
        assert resp.status_code == 200
        actual_status = resp.json()["TableDescription"]["TableStatus"]
        assert actual_status == expected_status, (
            f"Expected TableStatus '{expected_status}' but got '{actual_status}'"
        )
