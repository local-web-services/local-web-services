"""Tests for update_item with DynamoDB JSON input (real SDK wire format)."""

from __future__ import annotations

from pathlib import Path

import pytest

from lws.interfaces import (
    KeyAttribute,
    KeySchema,
    TableConfig,
)
from lws.providers.dynamodb.provider import SqliteDynamoProvider


def _simple_table_config() -> TableConfig:
    """Table with partition + sort key."""
    return TableConfig(
        table_name="orders",
        key_schema=KeySchema(
            partition_key=KeyAttribute(name="orderId", type="S"),
            sort_key=KeyAttribute(name="itemId", type="S"),
        ),
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


class TestUpdateItemDynamoJson:
    """update_item preserves DynamoDB JSON when items are stored typed."""

    async def test_set_preserves_dynamo_json_format(self, provider: SqliteDynamoProvider) -> None:
        # Arrange
        await provider.put_item(
            "orders",
            {
                "orderId": {"S": "o1"},
                "itemId": {"S": "i1"},
                "status": {"S": "new"},
            },
        )
        expected_status = {"S": "PROCESSED"}

        # Act
        result = await provider.update_item(
            "orders",
            {"orderId": {"S": "o1"}, "itemId": {"S": "i1"}},
            "SET #s = :v",
            expression_values={":v": {"S": "PROCESSED"}},
            expression_names={"#s": "status"},
        )

        # Assert
        actual_status = result["status"]
        assert actual_status == expected_status

    async def test_set_new_attribute_stays_dynamo_json(
        self, provider: SqliteDynamoProvider
    ) -> None:
        # Arrange
        await provider.put_item(
            "orders",
            {"orderId": {"S": "o1"}, "itemId": {"S": "i1"}},
        )
        expected_note = {"S": "urgent"}

        # Act
        result = await provider.update_item(
            "orders",
            {"orderId": {"S": "o1"}, "itemId": {"S": "i1"}},
            "SET note = :v",
            expression_values={":v": {"S": "urgent"}},
        )

        # Assert
        actual_note = result["note"]
        assert actual_note == expected_note

    async def test_get_after_update_returns_dynamo_json(
        self, provider: SqliteDynamoProvider
    ) -> None:
        # Arrange
        await provider.put_item(
            "orders",
            {
                "orderId": {"S": "o1"},
                "itemId": {"S": "i1"},
                "status": {"S": "new"},
            },
        )
        expected_status = {"S": "shipped"}

        # Act
        await provider.update_item(
            "orders",
            {"orderId": {"S": "o1"}, "itemId": {"S": "i1"}},
            "SET #s = :v",
            expression_values={":v": {"S": "shipped"}},
            expression_names={"#s": "status"},
        )
        fetched = await provider.get_item(
            "orders",
            {"orderId": {"S": "o1"}, "itemId": {"S": "i1"}},
        )

        # Assert
        actual_status = fetched["status"]
        assert actual_status == expected_status

    async def test_set_numeric_attribute_stays_dynamo_json(
        self, provider: SqliteDynamoProvider
    ) -> None:
        # Arrange
        await provider.put_item(
            "orders",
            {
                "orderId": {"S": "o1"},
                "itemId": {"S": "i1"},
                "qty": {"N": "1"},
            },
        )
        expected_qty = {"N": "10"}

        # Act
        result = await provider.update_item(
            "orders",
            {"orderId": {"S": "o1"}, "itemId": {"S": "i1"}},
            "SET qty = :v",
            expression_values={":v": {"N": "10"}},
        )

        # Assert
        actual_qty = result["qty"]
        assert actual_qty == expected_qty
