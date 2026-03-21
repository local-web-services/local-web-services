"""Tests for ServiceTaskBridge DynamoDB service integration dispatch."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeDynamoDB


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestServiceTaskBridgeInvokeDynamoDB:
    """DynamoDB service integration dispatching."""

    async def test_put_item_calls_provider(self) -> None:
        # Arrange
        expected_table = "orders"
        expected_item = {"id": {"S": "123"}}
        dynamo = FakeDynamoDB()
        bridge = make_bridge(dynamodb=dynamo)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::dynamodb:putItem",
            {"TableName": expected_table, "Item": expected_item},
        )

        # Assert
        actual_calls = dynamo.put_calls
        assert result == {}
        assert len(actual_calls) == 1
        assert actual_calls[0] == (expected_table, expected_item)

    async def test_get_item_returns_item(self) -> None:
        # Arrange
        expected_item = {"id": {"S": "42"}, "name": {"S": "Alice"}}
        dynamo = FakeDynamoDB()
        dynamo.get_responses["users"] = expected_item
        bridge = make_bridge(dynamodb=dynamo)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::dynamodb:getItem",
            {"TableName": "users", "Key": {"id": {"S": "42"}}},
        )

        # Assert
        actual_item = result["Item"]
        assert actual_item == expected_item

    async def test_get_item_returns_empty_when_not_found(self) -> None:
        # Arrange
        dynamo = FakeDynamoDB()
        bridge = make_bridge(dynamodb=dynamo)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::dynamodb:getItem",
            {"TableName": "users", "Key": {"id": {"S": "missing"}}},
        )

        # Assert
        actual_item = result["Item"]
        assert actual_item == {}

    async def test_put_item_missing_provider_raises(self) -> None:
        # Arrange
        bridge = make_bridge()
        expected_error = "No DynamoDB provider"

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke("arn:aws:states:::dynamodb:putItem", {})

    async def test_get_item_missing_provider_raises(self) -> None:
        # Arrange
        bridge = make_bridge()
        expected_error = "No DynamoDB provider"

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke("arn:aws:states:::dynamodb:getItem", {})
