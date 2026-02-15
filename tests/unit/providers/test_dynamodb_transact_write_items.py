"""Tests for DynamoDB TransactWriteItems operation."""

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


class TestTransactWriteItems:
    @pytest.mark.asyncio
    async def test_transact_write_put_items(
        self, mock_client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        # Arrange
        payload = {
            "TransactItems": [
                {
                    "Put": {
                        "TableName": "Users",
                        "Item": {"pk": {"S": "user#1"}, "name": {"S": "Alice"}},
                    }
                },
                {
                    "Put": {
                        "TableName": "Users",
                        "Item": {"pk": {"S": "user#2"}, "name": {"S": "Bob"}},
                    }
                },
            ]
        }
        expected_status_code = 200
        expected_put_count = 2

        # Act
        resp = await mock_client.post("/", json=payload, headers=_target("TransactWriteItems"))

        # Assert
        assert resp.status_code == expected_status_code
        assert resp.json() == {}
        assert mock_store.put_item.await_count == expected_put_count
        mock_store.put_item.assert_any_await(
            "Users", {"pk": {"S": "user#1"}, "name": {"S": "Alice"}}
        )
        mock_store.put_item.assert_any_await("Users", {"pk": {"S": "user#2"}, "name": {"S": "Bob"}})

    @pytest.mark.asyncio
    async def test_transact_write_delete_items(
        self, mock_client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        # Arrange
        payload = {
            "TransactItems": [
                {
                    "Delete": {
                        "TableName": "Users",
                        "Key": {"pk": {"S": "user#1"}},
                    }
                },
            ]
        }
        expected_status_code = 200

        # Act
        resp = await mock_client.post("/", json=payload, headers=_target("TransactWriteItems"))

        # Assert
        assert resp.status_code == expected_status_code
        mock_store.delete_item.assert_awaited_once_with("Users", {"pk": {"S": "user#1"}})

    @pytest.mark.asyncio
    async def test_transact_write_mixed_operations(
        self, mock_client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        # Arrange
        mock_store.get_item.return_value = {"pk": {"S": "user#3"}}
        payload = {
            "TransactItems": [
                {
                    "Put": {
                        "TableName": "Users",
                        "Item": {"pk": {"S": "user#1"}, "name": {"S": "Alice"}},
                    }
                },
                {
                    "Delete": {
                        "TableName": "Users",
                        "Key": {"pk": {"S": "user#2"}},
                    }
                },
                {
                    "ConditionCheck": {
                        "TableName": "Users",
                        "Key": {"pk": {"S": "user#3"}},
                        "ConditionExpression": "attribute_exists(pk)",
                    }
                },
            ]
        }
        expected_status_code = 200

        # Act
        resp = await mock_client.post("/", json=payload, headers=_target("TransactWriteItems"))

        # Assert
        assert resp.status_code == expected_status_code
        assert resp.json() == {}
        mock_store.put_item.assert_awaited_once()
        mock_store.delete_item.assert_awaited_once()

    @pytest.mark.asyncio
    async def test_transact_write_update_item(
        self, mock_client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        # Arrange
        payload = {
            "TransactItems": [
                {
                    "Update": {
                        "TableName": "Users",
                        "Key": {"pk": {"S": "user#1"}},
                        "UpdateExpression": "SET #n = :val",
                        "ExpressionAttributeNames": {"#n": "name"},
                        "ExpressionAttributeValues": {":val": {"S": "Updated"}},
                    }
                },
            ]
        }
        expected_status_code = 200

        # Act
        resp = await mock_client.post("/", json=payload, headers=_target("TransactWriteItems"))

        # Assert
        assert resp.status_code == expected_status_code
        mock_store.update_item.assert_awaited_once_with(
            "Users",
            {"pk": {"S": "user#1"}},
            "SET #n = :val",
            expression_values={":val": {"S": "Updated"}},
            expression_names={"#n": "name"},
        )

    @pytest.mark.asyncio
    async def test_transact_write_empty_list(
        self, mock_client: httpx.AsyncClient, mock_store: AsyncMock
    ) -> None:
        # Arrange
        payload = {"TransactItems": []}
        expected_status_code = 200

        # Act
        resp = await mock_client.post("/", json=payload, headers=_target("TransactWriteItems"))

        # Assert
        assert resp.status_code == expected_status_code
        assert resp.json() == {}

    @pytest.mark.asyncio
    async def test_transact_write_integration(
        self, real_client: httpx.AsyncClient, real_provider: SqliteDynamoProvider
    ) -> None:
        await real_provider.start()
        try:
            # Arrange
            expected_status_code = 200
            expected_name = {"S": "Alice"}
            payload = {
                "TransactItems": [
                    {
                        "Put": {
                            "TableName": "TestTable",
                            "Item": {
                                "pk": {"S": "user#1"},
                                "sk": {"S": "profile"},
                                "name": {"S": "Alice"},
                            },
                        }
                    },
                    {
                        "Put": {
                            "TableName": "TestTable",
                            "Item": {
                                "pk": {"S": "user#2"},
                                "sk": {"S": "profile"},
                                "name": {"S": "Bob"},
                            },
                        }
                    },
                ]
            }

            # Act - write items
            resp = await real_client.post("/", json=payload, headers=_target("TransactWriteItems"))

            # Assert - write succeeded
            assert resp.status_code == expected_status_code

            # Act - verify items were actually written
            get_resp = await real_client.post(
                "/",
                json={
                    "TableName": "TestTable",
                    "Key": {"pk": {"S": "user#1"}, "sk": {"S": "profile"}},
                },
                headers=_target("GetItem"),
            )

            # Assert - item exists with expected name
            assert get_resp.status_code == expected_status_code
            actual_name = get_resp.json()["Item"]["name"]
            assert actual_name == expected_name

            # Arrange - delete payload
            del_payload = {
                "TransactItems": [
                    {
                        "Delete": {
                            "TableName": "TestTable",
                            "Key": {"pk": {"S": "user#1"}, "sk": {"S": "profile"}},
                        }
                    },
                ]
            }

            # Act - delete item
            resp = await real_client.post(
                "/", json=del_payload, headers=_target("TransactWriteItems")
            )
            assert resp.status_code == expected_status_code

            # Act - verify deletion
            get_resp = await real_client.post(
                "/",
                json={
                    "TableName": "TestTable",
                    "Key": {"pk": {"S": "user#1"}, "sk": {"S": "profile"}},
                },
                headers=_target("GetItem"),
            )

            # Assert - item is gone
            assert get_resp.status_code == expected_status_code
            assert "Item" not in get_resp.json()
        finally:
            await real_provider.stop()
