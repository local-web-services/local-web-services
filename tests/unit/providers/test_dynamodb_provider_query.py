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


class TestQuery:
    """query() key condition parsing."""

    async def test_query_by_pk_only(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "v": 1})
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i2", "v": 2})
        await provider.put_item("orders", {"orderId": "o2", "itemId": "i1", "v": 3})

        results = await provider.query(
            "orders",
            "orderId = :pk",
            expression_values={":pk": "o1"},
        )
        assert len(results) == 2
        order_ids = {r["orderId"] for r in results}
        assert order_ids == {"o1"}

    async def test_query_pk_and_sk_eq(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "v": 1})
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i2", "v": 2})

        results = await provider.query(
            "orders",
            "orderId = :pk AND itemId = :sk",
            expression_values={":pk": "o1", ":sk": "i1"},
        )
        assert len(results) == 1
        assert results[0]["v"] == 1

    async def test_query_pk_and_sk_range(self, provider: SqliteDynamoProvider) -> None:
        for i in range(5):
            await provider.put_item(
                "orders",
                {"orderId": "o1", "itemId": f"item-{i:03d}", "v": i},
            )

        results = await provider.query(
            "orders",
            "orderId = :pk AND itemId BETWEEN :a AND :b",
            expression_values={":pk": "o1", ":a": "item-001", ":b": "item-003"},
        )
        assert len(results) == 3
        vals = sorted(r["v"] for r in results)
        assert vals == [1, 2, 3]

    async def test_query_begins_with(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "abc-1"})
        await provider.put_item("orders", {"orderId": "o1", "itemId": "abc-2"})
        await provider.put_item("orders", {"orderId": "o1", "itemId": "xyz-1"})

        results = await provider.query(
            "orders",
            "orderId = :pk AND begins_with(itemId, :prefix)",
            expression_values={":pk": "o1", ":prefix": "abc"},
        )
        assert len(results) == 2

    async def test_query_with_filter(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "status": "active"})
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i2", "status": "inactive"})

        results = await provider.query(
            "orders",
            "orderId = :pk",
            expression_values={":pk": "o1", ":s": "active"},
            filter_expression="status = :s",
        )
        assert len(results) == 1
        assert results[0]["status"] == "active"

    async def test_query_sk_gt(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "a"})
        await provider.put_item("orders", {"orderId": "o1", "itemId": "b"})
        await provider.put_item("orders", {"orderId": "o1", "itemId": "c"})

        results = await provider.query(
            "orders",
            "orderId = :pk AND itemId > :sk",
            expression_values={":pk": "o1", ":sk": "a"},
        )
        assert len(results) == 2
