"""Tests for DynamoDB FilterExpression evaluator (P1-23)."""

from __future__ import annotations

from lws.providers.dynamodb.expressions import (
    evaluate_filter_expression,
)


class TestDynamoJsonItemFunctions:
    """Built-in functions against items in DynamoDB JSON format (as stored in SQLite)."""

    def test_begins_with_dynamo_json_string(self) -> None:
        # Arrange
        item = {"name": {"S": "Alice"}}
        expression = "begins_with(name, :prefix)"
        expected_result = True

        # Act
        actual_result = evaluate_filter_expression(
            item, expression, expression_values={":prefix": {"S": "Al"}}
        )

        # Assert
        assert (
            actual_result == expected_result
        ), f"Expected {expected_result!r} but got {actual_result!r}"

    def test_contains_dynamo_json_string(self) -> None:
        # Arrange
        item = {"description": {"S": "hello world"}}
        expression = "contains(description, :sub)"
        expected_result = True

        # Act
        actual_result = evaluate_filter_expression(
            item, expression, expression_values={":sub": {"S": "world"}}
        )

        # Assert
        assert (
            actual_result == expected_result
        ), f"Expected {expected_result!r} but got {actual_result!r}"
