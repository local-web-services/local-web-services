"""Tests for ServiceTaskBridge capacity enforcement on DynamoDB dispatches."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeDynamoDB, FakeExhaustedCapacity, FakeUnlimitedCapacity


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestDynamoDbCapacity:
    """DynamoDB dispatch is blocked when capacity is exhausted."""

    async def test_put_item_raises_when_capacity_exhausted(self) -> None:
        # Arrange
        dynamo = FakeDynamoDB()
        bridge = make_bridge(dynamodb=dynamo, dynamodb_capacity=FakeExhaustedCapacity())
        expected_error = "DynamoDB capacity is exhausted"

        # Act / Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke(
                "arn:aws:states:::dynamodb:putItem",
                {"TableName": "orders", "Item": {"id": {"S": "1"}}},
            )

    async def test_get_item_raises_when_capacity_exhausted(self) -> None:
        # Arrange
        dynamo = FakeDynamoDB()
        bridge = make_bridge(dynamodb=dynamo, dynamodb_capacity=FakeExhaustedCapacity())
        expected_error = "DynamoDB capacity is exhausted"

        # Act / Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke(
                "arn:aws:states:::dynamodb:getItem",
                {"TableName": "orders", "Key": {"id": {"S": "1"}}},
            )

    async def test_put_item_succeeds_when_capacity_unlimited(self) -> None:
        # Arrange
        dynamo = FakeDynamoDB()
        bridge = make_bridge(dynamodb=dynamo, dynamodb_capacity=FakeUnlimitedCapacity())

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::dynamodb:putItem",
            {"TableName": "orders", "Item": {"id": {"S": "1"}}},
        )

        # Assert
        assert result == {}, f"Expected empty result dict but got {result!r}"
