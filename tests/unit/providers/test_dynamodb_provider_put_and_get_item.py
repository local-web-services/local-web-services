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
