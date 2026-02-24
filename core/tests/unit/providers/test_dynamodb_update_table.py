"""Tests for DynamoDB UpdateTable operation."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces.key_value_store import IKeyValueStore, KeyAttribute, KeySchema, TableConfig
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app

TARGET_PREFIX = "DynamoDB_20120810."


def _target(operation: str) -> dict[str, str]:
    return {"X-Amz-Target": f"{TARGET_PREFIX}{operation}"}


# ---------------------------------------------------------------------------
# Mock-based fixtures (for route-level unit tests)
# ---------------------------------------------------------------------------


@pytest.fixture()
def mock_store() -> AsyncMock:
    """Return an ``AsyncMock`` that satisfies ``IKeyValueStore``."""
    store = AsyncMock(spec=IKeyValueStore)
    store.get_item.return_value = None
    store.put_item.return_value = None
    store.delete_item.return_value = None
    store.update_item.return_value = {}
    store.query.return_value = []
    store.scan.return_value = []
    store.batch_get_items.return_value = []
    store.batch_write_items.return_value = None
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
    return store


@pytest.fixture()
def mock_client(mock_store: AsyncMock) -> httpx.AsyncClient:
    app = create_dynamodb_app(mock_store)
    transport = httpx.ASGITransport(app=app)
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


# ---------------------------------------------------------------------------
# Real provider fixtures (for integration tests)
# ---------------------------------------------------------------------------

_TABLE_CONFIG = TableConfig(
    table_name="TestTable",
    key_schema=KeySchema(
        partition_key=KeyAttribute(name="pk", type="S"),
        sort_key=KeyAttribute(name="sk", type="S"),
    ),
)


@pytest.fixture()
def real_provider(tmp_path) -> SqliteDynamoProvider:
    return SqliteDynamoProvider(data_dir=tmp_path, tables=[_TABLE_CONFIG])


@pytest.fixture()
def real_client(real_provider: SqliteDynamoProvider) -> httpx.AsyncClient:
    app = create_dynamodb_app(real_provider)
    transport = httpx.ASGITransport(app=app)
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


class TestUpdateTable:
    @pytest.mark.asyncio
    async def test_update_table_returns_table_description(
        self, mock_client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        # Arrange
        payload = {"TableName": "MyTable"}
        expected_status_code = 200
        expected_table_name = "MyTable"
        expected_table_status = "ACTIVE"

        # Act
        resp = await mock_client.post("/", json=payload, headers=_target("UpdateTable"))

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        assert "TableDescription" in data
        actual_table_name = data["TableDescription"]["TableName"]
        actual_table_status = data["TableDescription"]["TableStatus"]
        assert actual_table_name == expected_table_name
        assert actual_table_status == expected_table_status
        mock_store.describe_table.assert_awaited_once_with("MyTable")

    @pytest.mark.asyncio
    async def test_update_table_not_found(
        self, mock_client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        # Arrange
        mock_store.describe_table.side_effect = KeyError("Table not found: NoSuchTable")
        payload = {"TableName": "NoSuchTable"}
        expected_status_code = 400
        expected_error_type = "ResourceNotFoundException"

        # Act
        resp = await mock_client.post("/", json=payload, headers=_target("UpdateTable"))

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        actual_error_type = data["__type"]
        assert actual_error_type == expected_error_type

    @pytest.mark.asyncio
    async def test_update_table_integration(
        self, real_client: httpx.AsyncClient, real_provider: SqliteDynamoProvider
    ) -> None:
        await real_provider.start()
        try:
            # Arrange
            payload = {"TableName": "TestTable"}
            expected_status_code = 200
            expected_table_name = "TestTable"
            expected_table_status = "ACTIVE"
            expected_arn_suffix = "/TestTable"

            # Act
            resp = await real_client.post("/", json=payload, headers=_target("UpdateTable"))

            # Assert
            assert resp.status_code == expected_status_code
            data = resp.json()
            actual_table_name = data["TableDescription"]["TableName"]
            actual_table_status = data["TableDescription"]["TableStatus"]
            assert actual_table_name == expected_table_name
            assert actual_table_status == expected_table_status
            assert data["TableDescription"]["TableArn"].endswith(expected_arn_suffix)
        finally:
            await real_provider.stop()
