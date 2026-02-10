"""Tests for DynamoDB provider table management operations."""

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


def _simple_config(name: str = "orders") -> TableConfig:
    return TableConfig(
        table_name=name,
        key_schema=KeySchema(
            partition_key=KeyAttribute(name="pk", type="S"),
            sort_key=KeyAttribute(name="sk", type="S"),
        ),
    )


def _config_with_gsi() -> TableConfig:
    return TableConfig(
        table_name="users",
        key_schema=KeySchema(
            partition_key=KeyAttribute(name="userId", type="S"),
        ),
        gsi_definitions=[
            GsiDefinition(
                index_name="email_index",
                key_schema=KeySchema(
                    partition_key=KeyAttribute(name="email", type="S"),
                ),
                projection_type="ALL",
            ),
        ],
    )


@pytest.fixture
async def provider(tmp_path: Path):
    """Provider started with no tables."""
    p = SqliteDynamoProvider(data_dir=tmp_path)
    await p.start()
    yield p
    await p.stop()


class TestCreateTable:
    @pytest.mark.asyncio
    async def test_create_table(self, provider: SqliteDynamoProvider) -> None:
        config = _simple_config()
        result = await provider.create_table(config)

        assert result["TableName"] == "orders"
        assert result["TableStatus"] == "ACTIVE"

        tables = await provider.list_tables()
        assert "orders" in tables

    @pytest.mark.asyncio
    async def test_create_table_can_put_and_get(self, provider: SqliteDynamoProvider) -> None:
        await provider.create_table(_simple_config())

        item = {"pk": "p1", "sk": "s1", "data": "hello"}
        await provider.put_item("orders", item)
        result = await provider.get_item("orders", {"pk": "p1", "sk": "s1"})
        assert result is not None
        assert result["data"] == "hello"

    @pytest.mark.asyncio
    async def test_create_table_duplicate_raises(self, provider: SqliteDynamoProvider) -> None:
        await provider.create_table(_simple_config())

        with pytest.raises(ValueError, match="already exists"):
            await provider.create_table(_simple_config())

    @pytest.mark.asyncio
    async def test_create_table_with_gsi(self, provider: SqliteDynamoProvider) -> None:
        config = _config_with_gsi()
        result = await provider.create_table(config)

        assert result["TableName"] == "users"
        assert "GlobalSecondaryIndexes" in result
        assert result["GlobalSecondaryIndexes"][0]["IndexName"] == "email_index"
