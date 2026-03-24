"""Tests for ServiceTaskBridge DynamoDB table existence pre-flight validation."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeDynamoDB


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestServiceTaskBridgeDynamodbTargetValidation:
    """DynamoDB putItem/getItem pre-flight table existence checks."""

    async def test_put_item_succeeds_when_table_exists(self) -> None:
        # Arrange
        expected_table = "my-table"
        dynamo = FakeDynamoDB(tables={expected_table})
        bridge = make_bridge(dynamodb=dynamo)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::dynamodb:putItem",
            {"TableName": expected_table, "Item": {"id": {"S": "1"}}},
        )

        # Assert
        actual_result = result
        assert actual_result == {}, f"Expected empty result but got {actual_result!r}"

    async def test_put_item_raises_when_table_does_not_exist(self) -> None:
        # Arrange
        expected_error_pattern = "DynamoDB table does not exist"
        dynamo = FakeDynamoDB(tables=set())  # no tables
        bridge = make_bridge(dynamodb=dynamo)

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error_pattern):
            await bridge.invoke(
                "arn:aws:states:::dynamodb:putItem",
                {"TableName": "nonexistent-table", "Item": {"id": {"S": "1"}}},
            )

    async def test_get_item_succeeds_when_table_exists(self) -> None:
        # Arrange
        expected_table = "my-table"
        expected_item = {"id": {"S": "42"}}
        dynamo = FakeDynamoDB(tables={expected_table})
        dynamo.get_responses[expected_table] = expected_item
        bridge = make_bridge(dynamodb=dynamo)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::dynamodb:getItem",
            {"TableName": expected_table, "Key": {"id": {"S": "42"}}},
        )

        # Assert
        actual_item = result["Item"]
        assert (
            actual_item == expected_item
        ), f"Expected item {expected_item!r} but got {actual_item!r}"

    async def test_get_item_raises_when_table_does_not_exist(self) -> None:
        # Arrange
        expected_error_pattern = "DynamoDB table does not exist"
        dynamo = FakeDynamoDB(tables=set())
        bridge = make_bridge(dynamodb=dynamo)

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error_pattern):
            await bridge.invoke(
                "arn:aws:states:::dynamodb:getItem",
                {"TableName": "ghost-table", "Key": {"id": {"S": "1"}}},
            )
