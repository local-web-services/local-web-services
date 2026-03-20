"""Tests for DynamoDB DescribeContinuousBackups operation."""

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
# Fake-based fixtures (for route-level unit tests)
# ---------------------------------------------------------------------------


@pytest.fixture()
def fake_store() -> AsyncMock:
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
def fake_client(fake_store: AsyncMock) -> httpx.AsyncClient:
    app = create_dynamodb_app(fake_store)
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


class TestDescribeContinuousBackups:
    @pytest.mark.asyncio
    async def test_describe_continuous_backups(self, fake_client: httpx.AsyncClient) -> None:
        # Arrange
        payload = {"TableName": "MyTable"}
        expected_status_code = 200
        expected_backups_status = "DISABLED"
        expected_pitr_status = "DISABLED"

        # Act
        resp = await fake_client.post(
            "/", json=payload, headers=_target("DescribeContinuousBackups")
        )

        # Assert
        assert resp.status_code == expected_status_code, (
            f"Expected {expected_status_code!r} but got {resp.status_code!r}"
        )
        data = resp.json()
        assert "ContinuousBackupsDescription" in data, (
            f'Expected {"ContinuousBackupsDescription"!r} to be in {data!r}'
        )
        desc = data["ContinuousBackupsDescription"]
        actual_backups_status = desc["ContinuousBackupsStatus"]
        actual_pitr_status = desc["PointInTimeRecoveryDescription"]["PointInTimeRecoveryStatus"]
        assert actual_backups_status == expected_backups_status, (
            f"Expected {expected_backups_status!r} but got {actual_backups_status!r}"
        )
        assert actual_pitr_status == expected_pitr_status, (
            f"Expected {expected_pitr_status!r} but got {actual_pitr_status!r}"
        )
