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


class TestDescribeTable:
    @pytest.mark.asyncio
    async def test_describe_table_success(
        self, client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        # Arrange
        expected_status_code = 200
        expected_table_name = "MyTable"

        # Act
        resp = await client.post(
            "/", json={"TableName": "MyTable"}, headers=_target("DescribeTable")
        )

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        assert "Table" in data
        actual_table_name = data["Table"]["TableName"]
        assert actual_table_name == expected_table_name
        mock_store.describe_table.assert_awaited_once_with("MyTable")

    @pytest.mark.asyncio
    async def test_describe_table_not_found(
        self, client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        # Arrange
        mock_store.describe_table.side_effect = KeyError("Table not found: MyTable")
        expected_status_code = 400
        expected_error_type = "ResourceNotFoundException"

        # Act
        resp = await client.post(
            "/", json={"TableName": "MyTable"}, headers=_target("DescribeTable")
        )

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        actual_error_type = data["__type"]
        assert actual_error_type == expected_error_type
