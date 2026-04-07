"""Tests for DynamoDB FilterExpression evaluator (P1-23)."""

from __future__ import annotations

from lws.providers.dynamodb.expressions import (
    evaluate_filter_expression,
)


class TestDynamoJsonItemComparisons:
    """Comparison operators against items in DynamoDB JSON format (as stored in SQLite)."""

    def test_string_equality_on_dynamo_json_item(self) -> None:
        # Arrange
        item = {"status": {"S": "active"}}
        expression = "status = :v"
        expected_result = True

        # Act
        actual_result = evaluate_filter_expression(
            item, expression, expression_values={":v": {"S": "active"}}
        )

        # Assert
        assert (
            actual_result == expected_result
        ), f"Expected {expected_result!r} but got {actual_result!r}"

    def test_numeric_comparison_on_dynamo_json_item(self) -> None:
        # Arrange
        item = {"score": {"N": "42"}}
        expression = "score > :min"
        expected_result = True

        # Act
        actual_result = evaluate_filter_expression(
            item, expression, expression_values={":min": {"N": "10"}}
        )

        # Assert
        assert (
            actual_result == expected_result
        ), f"Expected {expected_result!r} but got {actual_result!r}"

    def test_string_equality_non_matching_on_dynamo_json_item(self) -> None:
        # Arrange
        item = {"status": {"S": "inactive"}}
        expression = "status = :v"
        expected_result = False

        # Act
        actual_result = evaluate_filter_expression(
            item, expression, expression_values={":v": {"S": "active"}}
        )

        # Assert
        assert (
            actual_result == expected_result
        ), f"Expected {expected_result!r} but got {actual_result!r}"
