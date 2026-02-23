"""Tests for DynamoDB UpdateTimeToLive operation."""

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


class TestUpdateTimeToLive:
    @pytest.mark.asyncio
    async def test_update_time_to_live_enable(self, mock_client: httpx.AsyncClient) -> None:
        # Arrange
        payload = {
            "TableName": "MyTable",
            "TimeToLiveSpecification": {
                "AttributeName": "ttl",
                "Enabled": True,
            },
        }
        expected_status_code = 200
        expected_attribute_name = "ttl"

        # Act
        resp = await mock_client.post("/", json=payload, headers=_target("UpdateTimeToLive"))

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        assert "TimeToLiveSpecification" in data
        spec = data["TimeToLiveSpecification"]
        actual_attribute_name = spec["AttributeName"]
        assert actual_attribute_name == expected_attribute_name
        assert spec["Enabled"] is True

    @pytest.mark.asyncio
    async def test_update_time_to_live_disable(self, mock_client: httpx.AsyncClient) -> None:
        # Arrange
        payload = {
            "TableName": "MyTable",
            "TimeToLiveSpecification": {
                "AttributeName": "ttl",
                "Enabled": False,
            },
        }
        expected_status_code = 200
        expected_attribute_name = "ttl"

        # Act
        resp = await mock_client.post("/", json=payload, headers=_target("UpdateTimeToLive"))

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        spec = data["TimeToLiveSpecification"]
        actual_attribute_name = spec["AttributeName"]
        assert actual_attribute_name == expected_attribute_name
        assert spec["Enabled"] is False

    @pytest.mark.asyncio
    async def test_update_time_to_live_missing_spec(self, mock_client: httpx.AsyncClient) -> None:
        # Arrange
        payload = {"TableName": "MyTable"}
        expected_status_code = 200
        expected_attribute_name = ""

        # Act
        resp = await mock_client.post("/", json=payload, headers=_target("UpdateTimeToLive"))

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        spec = data["TimeToLiveSpecification"]
        actual_attribute_name = spec["AttributeName"]
        assert actual_attribute_name == expected_attribute_name
        assert spec["Enabled"] is False
