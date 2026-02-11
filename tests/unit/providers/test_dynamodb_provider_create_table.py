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
        # Arrange
        config = _simple_config()
        expected_table_name = "orders"
        expected_status = "ACTIVE"

        # Act
        result = await provider.create_table(config)

        # Assert
        actual_table_name = result["TableName"]
        actual_status = result["TableStatus"]
        assert actual_table_name == expected_table_name
        assert actual_status == expected_status

        tables = await provider.list_tables()
        assert expected_table_name in tables

    @pytest.mark.asyncio
    async def test_create_table_can_put_and_get(self, provider: SqliteDynamoProvider) -> None:
        # Arrange
        await provider.create_table(_simple_config())
        item = {"pk": "p1", "sk": "s1", "data": "hello"}
        expected_data = "hello"
        await provider.put_item("orders", item)

        # Act
        result = await provider.get_item("orders", {"pk": "p1", "sk": "s1"})

        # Assert
        assert result is not None
        actual_data = result["data"]
        assert actual_data == expected_data

    @pytest.mark.asyncio
    async def test_create_table_duplicate_is_idempotent(
        self, provider: SqliteDynamoProvider
    ) -> None:
        # Act
        first = await provider.create_table(_simple_config())
        second = await provider.create_table(_simple_config())

        # Assert
        assert first["TableName"] == second["TableName"]

    @pytest.mark.asyncio
    async def test_create_table_with_gsi(self, provider: SqliteDynamoProvider) -> None:
        # Arrange
        config = _config_with_gsi()
        expected_table_name = "users"
        expected_index_name = "email_index"

        # Act
        result = await provider.create_table(config)

        # Assert
        actual_table_name = result["TableName"]
        actual_index_name = result["GlobalSecondaryIndexes"][0]["IndexName"]
        assert actual_table_name == expected_table_name
        assert "GlobalSecondaryIndexes" in result
        assert actual_index_name == expected_index_name
