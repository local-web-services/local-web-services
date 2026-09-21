"""Tests for ServiceTaskBridge DynamoDB service integration dispatch."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._engine_state import StatesTaskFailed
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
        expected_result = {}
        dynamo = FakeDynamoDB()
        bridge = make_bridge(dynamodb=dynamo)

        # Act
        actual_result = await bridge.invoke(
            "arn:aws:states:::dynamodb:getItem",
            {"TableName": "users", "Key": {"id": {"S": "missing"}}},
        )

        # Assert
        assert actual_result == expected_result
        assert "Item" not in actual_result

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

    async def test_update_item_calls_provider(self) -> None:
        # Arrange
        expected_table = "orders"
        expected_key = {"id": {"S": "123"}}
        expected_expression = "SET #s = :val"
        expected_attributes = {"id": {"S": "123"}, "status": {"S": "shipped"}}
        dynamo = FakeDynamoDB()
        dynamo.update_responses[expected_table] = expected_attributes
        bridge = make_bridge(dynamodb=dynamo)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::dynamodb:updateItem",
            {
                "TableName": expected_table,
                "Key": expected_key,
                "UpdateExpression": expected_expression,
                "ExpressionAttributeNames": {"#s": "status"},
                "ExpressionAttributeValues": {":val": {"S": "shipped"}},
            },
        )

        # Assert
        actual_calls = dynamo.update_calls
        assert len(actual_calls) == 1
        assert actual_calls[0] == (expected_table, expected_key, expected_expression)
        actual_attributes = result["Attributes"]
        assert actual_attributes == expected_attributes

    async def test_update_item_passes_condition_expression(self) -> None:
        # Arrange
        expected_condition = "attribute_exists(id)"
        dynamo = FakeDynamoDB()
        bridge = make_bridge(dynamodb=dynamo)
        received_kwargs: dict = {}

        async def capturing_update_item(
            table_name,
            key,
            update_expression,
            expression_values=None,
            expression_names=None,
            condition_expression=None,
        ):
            received_kwargs["condition_expression"] = condition_expression
            return {}

        dynamo.update_item = capturing_update_item  # type: ignore[method-assign]

        # Act
        await bridge.invoke(
            "arn:aws:states:::dynamodb:updateItem",
            {
                "TableName": "orders",
                "Key": {"id": {"S": "1"}},
                "UpdateExpression": "SET #s = :v",
                "ConditionExpression": expected_condition,
            },
        )

        # Assert
        actual_condition = received_kwargs["condition_expression"]
        assert actual_condition == expected_condition

    async def test_update_item_converts_condition_failure_to_states_error(self) -> None:
        # Arrange
        expected_error = "DynamoDB.ConditionalCheckFailedException"
        dynamo = FakeDynamoDB()

        async def raising_update_item(
            table_name,
            key,
            update_expression,
            expression_values=None,
            expression_names=None,
            condition_expression=None,
        ):
            raise KeyError("ConditionalCheckFailedException")

        dynamo.update_item = raising_update_item  # type: ignore[method-assign]
        bridge = make_bridge(dynamodb=dynamo)

        # Act
        # Assert
        with pytest.raises(StatesTaskFailed, match=expected_error):
            await bridge.invoke(
                "arn:aws:states:::dynamodb:updateItem",
                {
                    "TableName": "orders",
                    "Key": {"id": {"S": "1"}},
                    "UpdateExpression": "SET #s = :v",
                    "ConditionExpression": "attribute_exists(nonexistent)",
                },
            )

    async def test_update_item_missing_provider_raises(self) -> None:
        # Arrange
        bridge = make_bridge()
        expected_error = "No DynamoDB provider"

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke("arn:aws:states:::dynamodb:updateItem", {})
