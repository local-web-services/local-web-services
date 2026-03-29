"""Tests for DynamoDB transaction conflict detection."""

from __future__ import annotations

import asyncio

import httpx
import pytest

from lws.interfaces.key_value_store import IKeyValueStore, KeyAttribute, KeySchema, TableConfig
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import DynamoDbRouter, create_dynamodb_app

_TARGET_PREFIX = "DynamoDB_20120810."


def _target(operation: str) -> dict[str, str]:
    return {"X-Amz-Target": f"{_TARGET_PREFIX}{operation}"}


_TABLE_CONFIG = TableConfig(
    table_name="ConflictTable",
    key_schema=KeySchema(
        partition_key=KeyAttribute(name="pk", type="S"),
        sort_key=None,
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


class TestTransactionConflict:
    @pytest.mark.asyncio
    async def test_transact_write_succeeds_when_no_conflict(
        self, real_client: httpx.AsyncClient, real_provider: SqliteDynamoProvider
    ) -> None:
        await real_provider.start()
        try:
            # Arrange
            payload = {
                "TransactItems": [
                    {
                        "Put": {
                            "TableName": "ConflictTable",
                            "Item": {"pk": {"S": "item#1"}},
                        }
                    }
                ]
            }
            expected_status = 200

            # Act
            resp = await real_client.post("/", json=payload, headers=_target("TransactWriteItems"))

            # Assert
            actual_status = resp.status_code
            assert (
                actual_status == expected_status
            ), f"Expected {expected_status!r} but got {actual_status!r}"
        finally:
            await real_provider.stop()

    @pytest.mark.asyncio
    async def test_item_lock_key_is_stable(self) -> None:
        # Arrange
        from unittest.mock import AsyncMock

        store = AsyncMock(spec=IKeyValueStore)
        router = DynamoDbRouter(store)
        table_name = "TestTable"
        key = {"pk": {"S": "user#1"}}
        expected_prefix = "TestTable:"

        # Act
        actual_key = router._item_lock_key(table_name, key)  # pylint: disable=protected-access

        # Assert
        assert actual_key.startswith(
            expected_prefix
        ), f"Expected key to start with {expected_prefix!r} but got {actual_key!r}"

    @pytest.mark.asyncio
    async def test_sequential_transactions_on_same_item_both_succeed(
        self, real_client: httpx.AsyncClient, real_provider: SqliteDynamoProvider
    ) -> None:
        await real_provider.start()
        try:
            # Arrange - sequential (non-concurrent) transactions on the same item succeed
            payload = {
                "TransactItems": [
                    {
                        "Put": {
                            "TableName": "ConflictTable",
                            "Item": {"pk": {"S": "seq#1"}},
                        }
                    }
                ]
            }
            expected_status = 200

            # Act - first transaction
            resp_a = await real_client.post(
                "/", json=payload, headers=_target("TransactWriteItems")
            )
            # Act - second transaction on same item (sequential, not concurrent)
            resp_b = await real_client.post(
                "/", json=payload, headers=_target("TransactWriteItems")
            )

            # Assert - both succeed because they are sequential
            actual_status_a = resp_a.status_code
            assert (
                actual_status_a == expected_status
            ), f"Expected {expected_status!r} but got {actual_status_a!r}"
            actual_status_b = resp_b.status_code
            assert (
                actual_status_b == expected_status
            ), f"Expected {expected_status!r} but got {actual_status_b!r}"
        finally:
            await real_provider.stop()

    @pytest.mark.asyncio
    async def test_held_lock_causes_conflict_error(self) -> None:
        # Arrange - manually hold a lock to test conflict detection
        from unittest.mock import AsyncMock

        store = AsyncMock(spec=IKeyValueStore)
        store.put_item.return_value = None
        router = DynamoDbRouter(store)
        table_name = "ConflictTable"
        key = {"pk": {"S": "locked#1"}}
        lock_key = router._item_lock_key(table_name, key)  # pylint: disable=protected-access

        # Pre-acquire the lock to simulate a concurrent transaction holding it
        held_lock = asyncio.Lock()
        await held_lock.acquire()
        router._transaction_locks[lock_key] = held_lock  # pylint: disable=protected-access

        payload = {
            "TransactItems": [
                {
                    "Put": {
                        "TableName": table_name,
                        "Item": key,
                    }
                }
            ]
        }
        expected_status = 400
        expected_error_type = "TransactionCanceledException"

        # Act
        resp = await router._transact_write_items(payload)  # pylint: disable=protected-access

        # Assert
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        import json

        actual_body = json.loads(resp.body)
        actual_error_type = actual_body.get("__type")
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

        # Cleanup
        held_lock.release()
