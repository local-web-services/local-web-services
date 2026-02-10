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


class TestListTables:
    @pytest.mark.asyncio
    async def test_list_tables_empty(self, provider: SqliteDynamoProvider) -> None:
        tables = await provider.list_tables()
        assert tables == []

    @pytest.mark.asyncio
    async def test_list_tables_sorted(self, provider: SqliteDynamoProvider) -> None:
        await provider.create_table(_simple_config("zebra"))
        await provider.create_table(_simple_config("alpha"))
        await provider.create_table(_simple_config("middle"))

        tables = await provider.list_tables()
        assert tables == ["alpha", "middle", "zebra"]
