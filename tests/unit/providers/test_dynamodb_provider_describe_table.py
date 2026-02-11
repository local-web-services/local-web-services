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


class TestDescribeTable:
    @pytest.mark.asyncio
    async def test_describe_table(self, provider: SqliteDynamoProvider) -> None:
        # Arrange
        await provider.create_table(_simple_config())
        expected_table_name = "orders"
        expected_status = "ACTIVE"
        expected_arn = "arn:aws:dynamodb:us-east-1:000000000000:table/orders"
        expected_item_count = 0
        expected_size_bytes = 0
        expected_throughput = {
            "ReadCapacityUnits": 0,
            "WriteCapacityUnits": 0,
        }
        expected_key_schema_count = 2

        # Act
        result = await provider.describe_table("orders")

        # Assert
        actual_table_name = result["TableName"]
        actual_status = result["TableStatus"]
        actual_arn = result["TableArn"]
        actual_item_count = result["ItemCount"]
        actual_size_bytes = result["TableSizeBytes"]
        actual_throughput = result["ProvisionedThroughput"]
        assert actual_table_name == expected_table_name
        assert actual_status == expected_status
        assert actual_arn == expected_arn
        assert actual_item_count == expected_item_count
        assert actual_size_bytes == expected_size_bytes
        assert "CreationDateTime" in result
        assert actual_throughput == expected_throughput

        # Check KeySchema
        key_schema = result["KeySchema"]
        assert len(key_schema) == expected_key_schema_count
        assert {"AttributeName": "pk", "KeyType": "HASH"} in key_schema
        assert {"AttributeName": "sk", "KeyType": "RANGE"} in key_schema

        # Check AttributeDefinitions
        attr_defs = result["AttributeDefinitions"]
        assert {"AttributeName": "pk", "AttributeType": "S"} in attr_defs
        assert {"AttributeName": "sk", "AttributeType": "S"} in attr_defs

    @pytest.mark.asyncio
    async def test_describe_table_with_gsi(self, provider: SqliteDynamoProvider) -> None:
        # Arrange
        await provider.create_table(_config_with_gsi())
        expected_gsi_count = 1
        expected_index_name = "email_index"
        expected_projection_type = "ALL"

        # Act
        result = await provider.describe_table("users")

        # Assert
        gsis = result["GlobalSecondaryIndexes"]
        assert len(gsis) == expected_gsi_count
        actual_index_name = gsis[0]["IndexName"]
        actual_projection_type = gsis[0]["Projection"]["ProjectionType"]
        assert actual_index_name == expected_index_name
        assert actual_projection_type == expected_projection_type

    @pytest.mark.asyncio
    async def test_describe_table_nonexistent_raises(self, provider: SqliteDynamoProvider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.describe_table("nonexistent")
