"""Tests for DynamoDB FilterExpression evaluator (P1-23)."""

from __future__ import annotations

from lws.providers.dynamodb.expressions import (
    evaluate_filter_expression,
)


class TestDynamoJsonItemResolution:
    """Name and value resolution against items in DynamoDB JSON format (as stored in SQLite)."""

    def test_name_ref_resolves_dynamo_json_string_attribute(self) -> None:
        # Arrange
        item = {"status": {"S": "active"}}
        expression = "#s = :v"
        expected_result = True

        # Act
        actual_result = evaluate_filter_expression(
            item,
            expression,
            expression_names={"#s": "status"},
            expression_values={":v": {"S": "active"}},
        )

        # Assert
        assert (
            actual_result == expected_result
        ), f"Expected {expected_result!r} but got {actual_result!r}"

    def test_path_resolves_dynamo_json_numeric_attribute(self) -> None:
        # Arrange
        item = {"count": {"N": "7"}}
        expression = "count = :v"
        expected_result = True

        # Act
        actual_result = evaluate_filter_expression(
            item, expression, expression_values={":v": {"N": "7"}}
        )

        # Assert
        assert (
            actual_result == expected_result
        ), f"Expected {expected_result!r} but got {actual_result!r}"
