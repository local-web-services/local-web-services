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


class TestGSI:
    """GSI projection and query."""

    async def test_gsi_query(self, gsi_provider: SqliteDynamoProvider) -> None:
        # Arrange
        await gsi_provider.put_item(
            "orders",
            {
                "orderId": "o1",
                "itemId": "i1",
                "status": "shipped",
                "createdAt": "2024-01-01",
            },
        )
        await gsi_provider.put_item(
            "orders",
            {
                "orderId": "o2",
                "itemId": "i2",
                "status": "shipped",
                "createdAt": "2024-01-02",
            },
        )
        await gsi_provider.put_item(
            "orders",
            {
                "orderId": "o3",
                "itemId": "i3",
                "status": "pending",
                "createdAt": "2024-01-03",
            },
        )
        expected_count = 2
        expected_statuses = {"shipped"}

        # Act
        results = await gsi_provider.query(
            "orders",
            "status = :s",
            expression_values={":s": "shipped"},
            index_name="byStatus",
        )

        # Assert
        assert len(results) == expected_count
        actual_statuses = {r["status"] for r in results}
        assert actual_statuses == expected_statuses

    async def test_delete_cleans_gsi(self, gsi_provider: SqliteDynamoProvider) -> None:
        # Arrange
        await gsi_provider.put_item(
            "orders",
            {
                "orderId": "o1",
                "itemId": "i1",
                "status": "shipped",
                "createdAt": "2024-01-01",
            },
        )
        await gsi_provider.delete_item("orders", {"orderId": "o1", "itemId": "i1"})
        expected_count = 0

        # Act
        results = await gsi_provider.query(
            "orders",
            "status = :s",
            expression_values={":s": "shipped"},
            index_name="byStatus",
        )

        # Assert
        assert len(results) == expected_count
