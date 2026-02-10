"""Tests for DynamoDB TransactGetItems operation."""

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


class TestTransactGetItems:
    @pytest.mark.asyncio
    async def test_transact_get_items_found(
        self, mock_client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        mock_store.get_item.return_value = {
            "pk": {"S": "user#1"},
            "name": {"S": "Alice"},
        }
        payload = {
            "TransactItems": [
                {
                    "Get": {
                        "TableName": "Users",
                        "Key": {"pk": {"S": "user#1"}},
                    }
                },
            ]
        }
        resp = await mock_client.post("/", json=payload, headers=_target("TransactGetItems"))

        assert resp.status_code == 200
        data = resp.json()
        assert "Responses" in data
        assert len(data["Responses"]) == 1
        assert data["Responses"][0]["Item"]["pk"] == {"S": "user#1"}

    @pytest.mark.asyncio
    async def test_transact_get_items_not_found(
        self, mock_client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        mock_store.get_item.return_value = None
        payload = {
            "TransactItems": [
                {
                    "Get": {
                        "TableName": "Users",
                        "Key": {"pk": {"S": "user#999"}},
                    }
                },
            ]
        }
        resp = await mock_client.post("/", json=payload, headers=_target("TransactGetItems"))

        assert resp.status_code == 200
        data = resp.json()
        assert len(data["Responses"]) == 1
        assert data["Responses"][0] == {}

    @pytest.mark.asyncio
    async def test_transact_get_items_multiple(
        self, mock_client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        mock_store.get_item.side_effect = [
            {"pk": {"S": "user#1"}, "name": {"S": "Alice"}},
            None,
            {"pk": {"S": "user#3"}, "name": {"S": "Charlie"}},
        ]
        payload = {
            "TransactItems": [
                {"Get": {"TableName": "Users", "Key": {"pk": {"S": "user#1"}}}},
                {"Get": {"TableName": "Users", "Key": {"pk": {"S": "user#2"}}}},
                {"Get": {"TableName": "Users", "Key": {"pk": {"S": "user#3"}}}},
            ]
        }
        resp = await mock_client.post("/", json=payload, headers=_target("TransactGetItems"))

        assert resp.status_code == 200
        data = resp.json()
        assert len(data["Responses"]) == 3
        assert "Item" in data["Responses"][0]
        assert data["Responses"][1] == {}
        assert "Item" in data["Responses"][2]

    @pytest.mark.asyncio
    async def test_transact_get_items_empty(
        self, mock_client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        payload = {"TransactItems": []}
        resp = await mock_client.post("/", json=payload, headers=_target("TransactGetItems"))

        assert resp.status_code == 200
        assert resp.json() == {"Responses": []}

    @pytest.mark.asyncio
    async def test_transact_get_items_integration(
        self, real_client: httpx.AsyncClient, real_provider: SqliteDynamoProvider
    ) -> None:
        await real_provider.start()
        try:
            # Put items first
            for user_id, name in [("user#1", "Alice"), ("user#2", "Bob")]:
                await real_client.post(
                    "/",
                    json={
                        "TableName": "TestTable",
                        "Item": {
                            "pk": {"S": user_id},
                            "sk": {"S": "profile"},
                            "name": {"S": name},
                        },
                    },
                    headers=_target("PutItem"),
                )

            # TransactGetItems for existing and non-existing items
            payload = {
                "TransactItems": [
                    {
                        "Get": {
                            "TableName": "TestTable",
                            "Key": {"pk": {"S": "user#1"}, "sk": {"S": "profile"}},
                        }
                    },
                    {
                        "Get": {
                            "TableName": "TestTable",
                            "Key": {"pk": {"S": "user#999"}, "sk": {"S": "profile"}},
                        }
                    },
                    {
                        "Get": {
                            "TableName": "TestTable",
                            "Key": {"pk": {"S": "user#2"}, "sk": {"S": "profile"}},
                        }
                    },
                ]
            }
            resp = await real_client.post("/", json=payload, headers=_target("TransactGetItems"))
            assert resp.status_code == 200
            data = resp.json()
            assert len(data["Responses"]) == 3
            assert data["Responses"][0]["Item"]["name"] == {"S": "Alice"}
            assert data["Responses"][1] == {}
            assert data["Responses"][2]["Item"]["name"] == {"S": "Bob"}
        finally:
            await real_provider.stop()
