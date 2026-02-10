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
        await provider.create_table(_simple_config())
        result = await provider.describe_table("orders")

        assert result["TableName"] == "orders"
        assert result["TableStatus"] == "ACTIVE"
        assert result["TableArn"] == "arn:aws:dynamodb:us-east-1:000000000000:table/orders"
        assert result["ItemCount"] == 0
        assert result["TableSizeBytes"] == 0
        assert "CreationDateTime" in result
        assert result["ProvisionedThroughput"] == {
            "ReadCapacityUnits": 0,
            "WriteCapacityUnits": 0,
        }

        # Check KeySchema
        key_schema = result["KeySchema"]
        assert len(key_schema) == 2
        assert {"AttributeName": "pk", "KeyType": "HASH"} in key_schema
        assert {"AttributeName": "sk", "KeyType": "RANGE"} in key_schema

        # Check AttributeDefinitions
        attr_defs = result["AttributeDefinitions"]
        assert {"AttributeName": "pk", "AttributeType": "S"} in attr_defs
        assert {"AttributeName": "sk", "AttributeType": "S"} in attr_defs

    @pytest.mark.asyncio
    async def test_describe_table_with_gsi(self, provider: SqliteDynamoProvider) -> None:
        await provider.create_table(_config_with_gsi())
        result = await provider.describe_table("users")

        gsis = result["GlobalSecondaryIndexes"]
        assert len(gsis) == 1
        assert gsis[0]["IndexName"] == "email_index"
        assert gsis[0]["Projection"]["ProjectionType"] == "ALL"

    @pytest.mark.asyncio
    async def test_describe_table_nonexistent_raises(self, provider: SqliteDynamoProvider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.describe_table("nonexistent")
