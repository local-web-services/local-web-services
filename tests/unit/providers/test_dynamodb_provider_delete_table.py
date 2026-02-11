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


class TestDeleteTable:
    @pytest.mark.asyncio
    async def test_delete_table(self, provider: SqliteDynamoProvider, tmp_path: Path) -> None:
        # Arrange
        expected_table_name = "orders"
        await provider.create_table(_simple_config())
        tables = await provider.list_tables()
        assert expected_table_name in tables

        # Act
        result = await provider.delete_table("orders")

        # Assert
        actual_table_name = result["TableName"]
        assert actual_table_name == expected_table_name

        tables = await provider.list_tables()
        assert expected_table_name not in tables

        # DB file should be deleted
        db_path = tmp_path / "dynamodb" / "orders.db"
        assert not db_path.exists()

    @pytest.mark.asyncio
    async def test_delete_table_nonexistent_raises(self, provider: SqliteDynamoProvider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.delete_table("nonexistent")
