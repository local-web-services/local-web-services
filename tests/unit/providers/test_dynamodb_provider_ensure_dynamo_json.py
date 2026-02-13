"""Tests for _ensure_dynamo_json item-level helper."""

from __future__ import annotations

from lws.providers.dynamodb.provider import (
    _ensure_dynamo_json,
)


class TestEnsureDynamoJson:
    """_ensure_dynamo_json normalises mixed-format items to DynamoDB JSON."""

    def test_fully_typed_item_unchanged(self) -> None:
        # Arrange
        item = {"orderId": {"S": "o1"}, "status": {"S": "new"}}

        # Act
        actual_item = _ensure_dynamo_json(item)

        # Assert
        assert actual_item == item

    def test_fully_plain_item_wrapped(self) -> None:
        # Arrange
        expected_item = {"orderId": {"S": "o1"}, "count": {"N": "3"}}

        # Act
        actual_item = _ensure_dynamo_json({"orderId": "o1", "count": 3})

        # Assert
        assert actual_item == expected_item

    def test_mixed_item_normalised(self) -> None:
        # Arrange
        mixed_item = {
            "orderId": {"S": "o1"},
            "status": "PROCESSED",
            "count": 5,
        }
        expected_item = {
            "orderId": {"S": "o1"},
            "status": {"S": "PROCESSED"},
            "count": {"N": "5"},
        }

        # Act
        actual_item = _ensure_dynamo_json(mixed_item)

        # Assert
        assert actual_item == expected_item

    def test_empty_item(self) -> None:
        # Arrange
        # Act
        actual_item = _ensure_dynamo_json({})

        # Assert
        assert actual_item == {}
