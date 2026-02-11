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


class TestUpdateItem:
    """update_item SET and REMOVE operations."""

    async def test_set_existing_attribute(self, provider: SqliteDynamoProvider) -> None:
        # Arrange
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "status": "new"})
        expected_status = "shipped"

        # Act
        result = await provider.update_item(
            "orders",
            {"orderId": "o1", "itemId": "i1"},
            "SET #s = :v",
            expression_values={":v": "shipped"},
            expression_names={"#s": "status"},
        )

        # Assert
        actual_status = result["status"]
        assert actual_status == expected_status

    async def test_set_new_attribute(self, provider: SqliteDynamoProvider) -> None:
        # Arrange
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1"})
        expected_note = "urgent"

        # Act
        result = await provider.update_item(
            "orders",
            {"orderId": "o1", "itemId": "i1"},
            "SET note = :v",
            expression_values={":v": "urgent"},
        )

        # Assert
        actual_note = result["note"]
        assert actual_note == expected_note

    async def test_remove_attribute(self, provider: SqliteDynamoProvider) -> None:
        # Arrange
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "temp": "gone"})

        # Act
        result = await provider.update_item(
            "orders",
            {"orderId": "o1", "itemId": "i1"},
            "REMOVE temp",
        )

        # Assert
        assert "temp" not in result

    async def test_set_and_remove_combined(self, provider: SqliteDynamoProvider) -> None:
        # Arrange
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "a": 1, "b": 2})
        expected_a = 99

        # Act
        result = await provider.update_item(
            "orders",
            {"orderId": "o1", "itemId": "i1"},
            "SET a = :newA REMOVE b",
            expression_values={":newA": 99},
        )

        # Assert
        actual_a = result["a"]
        assert actual_a == expected_a
        assert "b" not in result

    async def test_update_creates_item_if_missing(self, provider: SqliteDynamoProvider) -> None:
        # Arrange
        expected_color = "red"
        expected_order_id = "o1"

        # Act
        result = await provider.update_item(
            "orders",
            {"orderId": "o1", "itemId": "i1"},
            "SET color = :c",
            expression_values={":c": "red"},
        )

        # Assert
        actual_color = result["color"]
        actual_order_id = result["orderId"]
        assert actual_color == expected_color
        assert actual_order_id == expected_order_id
