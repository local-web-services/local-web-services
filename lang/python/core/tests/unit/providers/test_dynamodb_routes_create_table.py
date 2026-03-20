"""Tests for DynamoDB route-level table management operations."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces.key_value_store import IKeyValueStore
from lws.providers.dynamodb.routes import create_dynamodb_app

TARGET_PREFIX = "DynamoDB_20120810."


def _target(operation: str) -> dict[str, str]:
    return {"X-Amz-Target": f"{TARGET_PREFIX}{operation}"}


@pytest.fixture()
def fake_store() -> AsyncMock:
    store = AsyncMock(spec=IKeyValueStore)
    store.get_item.return_value = None
    store.put_item.return_value = None
    store.delete_item.return_value = None
    store.update_item.return_value = {}
    store.query.return_value = []
    store.scan.return_value = []
    store.batch_get_items.return_value = []
    store.batch_write_items.return_value = None
    store.create_table.return_value = {
        "TableName": "MyTable",
        "TableStatus": "ACTIVE",
        "KeySchema": [{"AttributeName": "pk", "KeyType": "HASH"}],
        "AttributeDefinitions": [{"AttributeName": "pk", "AttributeType": "S"}],
        "TableArn": "arn:aws:dynamodb:us-east-1:000000000000:table/MyTable",
        "ItemCount": 0,
        "TableSizeBytes": 0,
        "CreationDateTime": 1234567890.0,
        "ProvisionedThroughput": {"ReadCapacityUnits": 0, "WriteCapacityUnits": 0},
    }
    store.delete_table.return_value = {
        "TableName": "MyTable",
        "TableStatus": "ACTIVE",
        "KeySchema": [{"AttributeName": "pk", "KeyType": "HASH"}],
        "AttributeDefinitions": [{"AttributeName": "pk", "AttributeType": "S"}],
        "TableArn": "arn:aws:dynamodb:us-east-1:000000000000:table/MyTable",
        "ItemCount": 0,
        "TableSizeBytes": 0,
        "CreationDateTime": 1234567890.0,
        "ProvisionedThroughput": {"ReadCapacityUnits": 0, "WriteCapacityUnits": 0},
    }
    store.describe_table.return_value = {
        "TableName": "MyTable",
        "TableStatus": "ACTIVE",
        "KeySchema": [{"AttributeName": "pk", "KeyType": "HASH"}],
        "AttributeDefinitions": [{"AttributeName": "pk", "AttributeType": "S"}],
        "TableArn": "arn:aws:dynamodb:us-east-1:000000000000:table/MyTable",
        "ItemCount": 0,
        "TableSizeBytes": 0,
        "CreationDateTime": 1234567890.0,
        "ProvisionedThroughput": {"ReadCapacityUnits": 0, "WriteCapacityUnits": 0},
    }
    store.list_tables.return_value = ["TableA", "TableB"]
    return store


@pytest.fixture()
def client(fake_store: AsyncMock) -> httpx.AsyncClient:
    app = create_dynamodb_app(fake_store)
    transport = httpx.ASGITransport(app=app)
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


class TestCreateTable:
    @pytest.mark.asyncio
    async def test_create_table_success(
        self, client: httpx.AsyncClient, fake_store: AsyncMock
    ) -> None:
        # Arrange
        payload = {
            "TableName": "MyTable",
            "KeySchema": [{"AttributeName": "pk", "KeyType": "HASH"}],
            "AttributeDefinitions": [{"AttributeName": "pk", "AttributeType": "S"}],
        }
        expected_status_code = 200
        expected_table_name = "MyTable"
        expected_table_status = "ACTIVE"

        # Act
        resp = await client.post("/", json=payload, headers=_target("CreateTable"))

        # Assert
        assert resp.status_code == expected_status_code, f"Expected {expected_status_code!r} but got {resp.status_code!r}"
        data = resp.json()
        assert "TableDescription" in data, f'Expected {"TableDescription"!r} to be in {data!r}'
        actual_table_name = data["TableDescription"]["TableName"]
        actual_table_status = data["TableDescription"]["TableStatus"]
        assert actual_table_name == expected_table_name, f"Expected {expected_table_name!r} but got {actual_table_name!r}"
        assert actual_table_status == expected_table_status, f"Expected {expected_table_status!r} but got {actual_table_status!r}"
        fake_store.create_table.assert_awaited_once()

    @pytest.mark.asyncio
    async def test_create_table_idempotent(
        self, client: httpx.AsyncClient, fake_store: AsyncMock
    ) -> None:
        # Arrange
        fake_store.create_table.return_value = {"TableName": "MyTable", "TableStatus": "ACTIVE"}
        payload = {
            "TableName": "MyTable",
            "KeySchema": [{"AttributeName": "pk", "KeyType": "HASH"}],
            "AttributeDefinitions": [{"AttributeName": "pk", "AttributeType": "S"}],
        }
        expected_status_code = 200

        # Act
        resp = await client.post("/", json=payload, headers=_target("CreateTable"))

        # Assert
        assert resp.status_code == expected_status_code, f"Expected {expected_status_code!r} but got {resp.status_code!r}"
        data = resp.json()
        assert "TableDescription" in data, f'Expected {"TableDescription"!r} to be in {data!r}'

    @pytest.mark.asyncio
    async def test_create_table_with_gsi(
        self, client: httpx.AsyncClient, fake_store: AsyncMock
    ) -> None:
        # Arrange
        payload = {
            "TableName": "MyTable",
            "KeySchema": [{"AttributeName": "pk", "KeyType": "HASH"}],
            "AttributeDefinitions": [
                {"AttributeName": "pk", "AttributeType": "S"},
                {"AttributeName": "gsi1pk", "AttributeType": "S"},
            ],
            "GlobalSecondaryIndexes": [
                {
                    "IndexName": "gsi1",
                    "KeySchema": [{"AttributeName": "gsi1pk", "KeyType": "HASH"}],
                    "Projection": {"ProjectionType": "ALL"},
                }
            ],
        }
        expected_status_code = 200
        expected_table_name = "MyTable"
        expected_gsi_count = 1
        expected_index_name = "gsi1"

        # Act
        resp = await client.post("/", json=payload, headers=_target("CreateTable"))

        # Assert
        assert resp.status_code == expected_status_code, f"Expected {expected_status_code!r} but got {resp.status_code!r}"
        call_args = fake_store.create_table.call_args
        config = call_args[0][0]
        actual_table_name = config.table_name
        actual_index_name = config.gsi_definitions[0].index_name
        assert actual_table_name == expected_table_name, f"Expected {expected_table_name!r} but got {actual_table_name!r}"
        assert len(config.gsi_definitions) == expected_gsi_count, f"Expected {expected_gsi_count!r} but got {len(config.gsi_definitions)!r}"
        assert actual_index_name == expected_index_name, f"Expected {expected_index_name!r} but got {actual_index_name!r}"
