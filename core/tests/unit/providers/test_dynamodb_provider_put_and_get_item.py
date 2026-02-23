"""Tests for SqliteDynamoProvider (P0-14 and P0-15)."""

from __future__ import annotations

from pathlib import Path

import pytest

from lws.interfaces import (
    GsiDefinition,
    KeyAttribute,
    KeySchema,
    TableConfig,
)
from lws.providers.dynamodb.provider import SqliteDynamoProvider

# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------


def _simple_table_config() -> TableConfig:
    """Table with partition + sort key, no GSIs."""
    return TableConfig(
        table_name="orders",
        key_schema=KeySchema(
            partition_key=KeyAttribute(name="orderId", type="S"),
            sort_key=KeyAttribute(name="itemId", type="S"),
        ),
    )


def _pk_only_table_config() -> TableConfig:
    """Table with partition key only."""
    return TableConfig(
        table_name="users",
        key_schema=KeySchema(
            partition_key=KeyAttribute(name="userId", type="S"),
        ),
    )


def _gsi_table_config() -> TableConfig:
    """Table with a GSI."""
    return TableConfig(
        table_name="orders",
        key_schema=KeySchema(
            partition_key=KeyAttribute(name="orderId", type="S"),
            sort_key=KeyAttribute(name="itemId", type="S"),
        ),
        gsi_definitions=[
            GsiDefinition(
                index_name="byStatus",
                key_schema=KeySchema(
                    partition_key=KeyAttribute(name="status", type="S"),
                    sort_key=KeyAttribute(name="createdAt", type="S"),
                ),
            ),
        ],
    )


@pytest.fixture
async def provider(tmp_path: Path):
    """Create, start, yield, and stop a provider with a simple table."""
    p = SqliteDynamoProvider(
        data_dir=tmp_path,
        tables=[_simple_table_config()],
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
async def pk_provider(tmp_path: Path):
    """Provider with a partition-key-only table."""
    p = SqliteDynamoProvider(
        data_dir=tmp_path,
        tables=[_pk_only_table_config()],
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
async def gsi_provider(tmp_path: Path):
    """Provider with a GSI-enabled table."""
    p = SqliteDynamoProvider(
        data_dir=tmp_path,
        tables=[_gsi_table_config()],
    )
    await p.start()
    yield p
    await p.stop()


# ---------------------------------------------------------------------------
# P0-14: Table setup and basic CRUD
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P0-15: Query and scan
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Persistence and GSI
# ---------------------------------------------------------------------------


class TestPutAndGetItem:
    """put_item / get_item round-trip tests."""

    async def test_round_trip(self, provider: SqliteDynamoProvider) -> None:
        # Arrange
        item = {"orderId": "o1", "itemId": "i1", "quantity": 5}
        expected_order_id = "o1"
        expected_quantity = 5
        await provider.put_item("orders", item)

        # Act
        result = await provider.get_item("orders", {"orderId": "o1", "itemId": "i1"})

        # Assert
        assert result is not None
        actual_order_id = result["orderId"]
        actual_quantity = result["quantity"]
        assert actual_order_id == expected_order_id
        assert actual_quantity == expected_quantity

    async def test_round_trip_dynamo_json(self, provider: SqliteDynamoProvider) -> None:
        # Arrange
        item = {
            "orderId": {"S": "o2"},
            "itemId": {"S": "i2"},
            "quantity": {"N": "10"},
        }
        expected_order_id = {"S": "o2"}
        await provider.put_item("orders", item)

        # Act
        result = await provider.get_item("orders", {"orderId": {"S": "o2"}, "itemId": {"S": "i2"}})

        # Assert
        assert result is not None
        actual_order_id = result["orderId"]
        assert actual_order_id == expected_order_id

    async def test_put_overwrites_existing(self, provider: SqliteDynamoProvider) -> None:
        # Arrange
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "v": 1})
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "v": 2})
        expected_v = 2

        # Act
        result = await provider.get_item("orders", {"orderId": "o1", "itemId": "i1"})

        # Assert
        assert result is not None
        actual_v = result["v"]
        assert actual_v == expected_v

    async def test_get_missing_returns_none(self, provider: SqliteDynamoProvider) -> None:
        # Act
        result = await provider.get_item("orders", {"orderId": "nope", "itemId": "nada"})

        # Assert
        assert result is None

    async def test_pk_only_table(self, pk_provider: SqliteDynamoProvider) -> None:
        # Arrange
        await pk_provider.put_item("users", {"userId": "u1", "name": "Alice"})
        expected_name = "Alice"

        # Act
        result = await pk_provider.get_item("users", {"userId": "u1"})

        # Assert
        assert result is not None
        actual_name = result["name"]
        assert actual_name == expected_name
