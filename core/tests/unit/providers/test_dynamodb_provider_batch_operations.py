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


class TestBatchOperations:
    """batch_get_items and batch_write_items."""

    async def test_batch_get_items(self, provider: SqliteDynamoProvider) -> None:
        # Arrange
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "v": 1})
        await provider.put_item("orders", {"orderId": "o2", "itemId": "i2", "v": 2})
        expected_count = 2

        # Act
        results = await provider.batch_get_items(
            "orders",
            [
                {"orderId": "o1", "itemId": "i1"},
                {"orderId": "o2", "itemId": "i2"},
                {"orderId": "missing", "itemId": "nope"},
            ],
        )

        # Assert
        assert len(results) == expected_count

    async def test_batch_write_items(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "v": 1})

        await provider.batch_write_items(
            "orders",
            put_items=[
                {"orderId": "o2", "itemId": "i2", "v": 2},
                {"orderId": "o3", "itemId": "i3", "v": 3},
            ],
            delete_keys=[{"orderId": "o1", "itemId": "i1"}],
        )

        assert await provider.get_item("orders", {"orderId": "o1", "itemId": "i1"}) is None
        assert await provider.get_item("orders", {"orderId": "o2", "itemId": "i2"}) is not None
        assert await provider.get_item("orders", {"orderId": "o3", "itemId": "i3"}) is not None
