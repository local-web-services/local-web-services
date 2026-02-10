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
def mock_store() -> AsyncMock:
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
def client(mock_store: AsyncMock) -> httpx.AsyncClient:
    app = create_dynamodb_app(mock_store)
    transport = httpx.ASGITransport(app=app)
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


class TestCreateTable:
    @pytest.mark.asyncio
    async def test_create_table_success(
        self, client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        payload = {
            "TableName": "MyTable",
            "KeySchema": [{"AttributeName": "pk", "KeyType": "HASH"}],
            "AttributeDefinitions": [{"AttributeName": "pk", "AttributeType": "S"}],
        }
        resp = await client.post("/", json=payload, headers=_target("CreateTable"))

        assert resp.status_code == 200
        data = resp.json()
        assert "TableDescription" in data
        assert data["TableDescription"]["TableName"] == "MyTable"
        assert data["TableDescription"]["TableStatus"] == "ACTIVE"
        mock_store.create_table.assert_awaited_once()

    @pytest.mark.asyncio
    async def test_create_table_already_exists(
        self, client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        mock_store.create_table.side_effect = ValueError("Table already exists: MyTable")

        payload = {
            "TableName": "MyTable",
            "KeySchema": [{"AttributeName": "pk", "KeyType": "HASH"}],
            "AttributeDefinitions": [{"AttributeName": "pk", "AttributeType": "S"}],
        }
        resp = await client.post("/", json=payload, headers=_target("CreateTable"))

        assert resp.status_code == 400
        data = resp.json()
        assert data["__type"] == "ResourceInUseException"

    @pytest.mark.asyncio
    async def test_create_table_with_gsi(
        self, client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
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
        resp = await client.post("/", json=payload, headers=_target("CreateTable"))

        assert resp.status_code == 200
        # Verify the config was parsed correctly
        call_args = mock_store.create_table.call_args
        config = call_args[0][0]
        assert config.table_name == "MyTable"
        assert len(config.gsi_definitions) == 1
        assert config.gsi_definitions[0].index_name == "gsi1"
