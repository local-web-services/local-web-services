"""Tests for SqliteDynamoProvider (P0-14 and P0-15)."""

from __future__ import annotations

from pathlib import Path

import pytest

from ldk.interfaces import (
    GsiDefinition,
    KeyAttribute,
    KeySchema,
    TableConfig,
)
from ldk.providers.dynamodb.provider import SqliteDynamoProvider

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


class TestProviderLifecycle:
    """Provider name, start, stop, health_check."""

    async def test_name(self, provider: SqliteDynamoProvider) -> None:
        assert provider.name == "dynamodb"

    async def test_health_check_running(self, provider: SqliteDynamoProvider) -> None:
        assert await provider.health_check() is True

    async def test_health_check_stopped(self, tmp_path: Path) -> None:
        p = SqliteDynamoProvider(data_dir=tmp_path, tables=[_simple_table_config()])
        # Not started yet -- no connections
        assert await p.health_check() is False


class TestPutAndGetItem:
    """put_item / get_item round-trip tests."""

    async def test_round_trip(self, provider: SqliteDynamoProvider) -> None:
        item = {"orderId": "o1", "itemId": "i1", "quantity": 5}
        await provider.put_item("orders", item)
        result = await provider.get_item("orders", {"orderId": "o1", "itemId": "i1"})
        assert result is not None
        assert result["orderId"] == "o1"
        assert result["quantity"] == 5

    async def test_round_trip_dynamo_json(self, provider: SqliteDynamoProvider) -> None:
        item = {
            "orderId": {"S": "o2"},
            "itemId": {"S": "i2"},
            "quantity": {"N": "10"},
        }
        await provider.put_item("orders", item)
        result = await provider.get_item("orders", {"orderId": {"S": "o2"}, "itemId": {"S": "i2"}})
        assert result is not None
        assert result["orderId"] == {"S": "o2"}

    async def test_put_overwrites_existing(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "v": 1})
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "v": 2})
        result = await provider.get_item("orders", {"orderId": "o1", "itemId": "i1"})
        assert result is not None
        assert result["v"] == 2

    async def test_get_missing_returns_none(self, provider: SqliteDynamoProvider) -> None:
        result = await provider.get_item("orders", {"orderId": "nope", "itemId": "nada"})
        assert result is None

    async def test_pk_only_table(self, pk_provider: SqliteDynamoProvider) -> None:
        await pk_provider.put_item("users", {"userId": "u1", "name": "Alice"})
        result = await pk_provider.get_item("users", {"userId": "u1"})
        assert result is not None
        assert result["name"] == "Alice"


class TestDeleteItem:
    """delete_item removes items."""

    async def test_delete_removes_item(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "v": 1})
        await provider.delete_item("orders", {"orderId": "o1", "itemId": "i1"})
        result = await provider.get_item("orders", {"orderId": "o1", "itemId": "i1"})
        assert result is None

    async def test_delete_nonexistent_no_error(self, provider: SqliteDynamoProvider) -> None:
        # Should not raise
        await provider.delete_item("orders", {"orderId": "nope", "itemId": "nada"})


class TestUpdateItem:
    """update_item SET and REMOVE operations."""

    async def test_set_existing_attribute(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "status": "new"})
        result = await provider.update_item(
            "orders",
            {"orderId": "o1", "itemId": "i1"},
            "SET #s = :v",
            expression_values={":v": "shipped"},
            expression_names={"#s": "status"},
        )
        assert result["status"] == "shipped"

    async def test_set_new_attribute(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1"})
        result = await provider.update_item(
            "orders",
            {"orderId": "o1", "itemId": "i1"},
            "SET note = :v",
            expression_values={":v": "urgent"},
        )
        assert result["note"] == "urgent"

    async def test_remove_attribute(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "temp": "gone"})
        result = await provider.update_item(
            "orders",
            {"orderId": "o1", "itemId": "i1"},
            "REMOVE temp",
        )
        assert "temp" not in result

    async def test_set_and_remove_combined(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "a": 1, "b": 2})
        result = await provider.update_item(
            "orders",
            {"orderId": "o1", "itemId": "i1"},
            "SET a = :newA REMOVE b",
            expression_values={":newA": 99},
        )
        assert result["a"] == 99
        assert "b" not in result

    async def test_update_creates_item_if_missing(self, provider: SqliteDynamoProvider) -> None:
        result = await provider.update_item(
            "orders",
            {"orderId": "o1", "itemId": "i1"},
            "SET color = :c",
            expression_values={":c": "red"},
        )
        assert result["color"] == "red"
        assert result["orderId"] == "o1"


# ---------------------------------------------------------------------------
# P0-15: Query and scan
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


class TestScan:
    """scan() full-table and filtered scans."""

    async def test_scan_returns_all(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1"})
        await provider.put_item("orders", {"orderId": "o2", "itemId": "i2"})
        results = await provider.scan("orders")
        assert len(results) == 2

    async def test_scan_with_filter(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "status": "active"})
        await provider.put_item("orders", {"orderId": "o2", "itemId": "i2", "status": "inactive"})
        results = await provider.scan(
            "orders",
            filter_expression="status = :s",
            expression_values={":s": "active"},
        )
        assert len(results) == 1
        assert results[0]["status"] == "active"


class TestBatchOperations:
    """batch_get_items and batch_write_items."""

    async def test_batch_get_items(self, provider: SqliteDynamoProvider) -> None:
        await provider.put_item("orders", {"orderId": "o1", "itemId": "i1", "v": 1})
        await provider.put_item("orders", {"orderId": "o2", "itemId": "i2", "v": 2})

        results = await provider.batch_get_items(
            "orders",
            [
                {"orderId": "o1", "itemId": "i1"},
                {"orderId": "o2", "itemId": "i2"},
                {"orderId": "missing", "itemId": "nope"},
            ],
        )
        assert len(results) == 2

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


# ---------------------------------------------------------------------------
# Persistence and GSI
# ---------------------------------------------------------------------------


class TestPersistence:
    """Data survives stop/start cycle."""

    async def test_data_persists_across_restart(self, tmp_path: Path) -> None:
        config = [_simple_table_config()]

        p1 = SqliteDynamoProvider(data_dir=tmp_path, tables=config)
        await p1.start()
        await p1.put_item("orders", {"orderId": "o1", "itemId": "i1", "v": 42})
        await p1.stop()

        p2 = SqliteDynamoProvider(data_dir=tmp_path, tables=config)
        await p2.start()
        result = await p2.get_item("orders", {"orderId": "o1", "itemId": "i1"})
        assert result is not None
        assert result["v"] == 42
        await p2.stop()


class TestGSI:
    """GSI projection and query."""

    async def test_gsi_query(self, gsi_provider: SqliteDynamoProvider) -> None:
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

        results = await gsi_provider.query(
            "orders",
            "status = :s",
            expression_values={":s": "shipped"},
            index_name="byStatus",
        )
        assert len(results) == 2
        statuses = {r["status"] for r in results}
        assert statuses == {"shipped"}

    async def test_delete_cleans_gsi(self, gsi_provider: SqliteDynamoProvider) -> None:
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

        results = await gsi_provider.query(
            "orders",
            "status = :s",
            expression_values={":s": "shipped"},
            index_name="byStatus",
        )
        assert len(results) == 0
