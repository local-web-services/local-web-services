"""Tests for DynamoDB UpdateExpression evaluator (P1-24)."""

from __future__ import annotations

from lws.providers.dynamodb.update_expression import (
    apply_update_expression,
)

# ---------------------------------------------------------------------------
# SET: regular assignment
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# SET: if_not_exists
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# SET: list_append
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# SET: arithmetic
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# REMOVE
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ADD
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# DELETE (from set)
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Combined clauses
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Parser tests
# ---------------------------------------------------------------------------


class TestSetIfNotExists:
    """Test SET with if_not_exists function."""

    def test_if_not_exists_attribute_missing(self) -> None:
        # Arrange
        item = {"pk": "1"}
        expected_count = 0

        # Act
        result = apply_update_expression(
            item,
            "SET count = if_not_exists(count, :default)",
            expression_values={":default": {"N": "0"}},
        )

        # Assert
        actual_count = result["count"]
        assert actual_count == expected_count

    def test_if_not_exists_attribute_present(self) -> None:
        # Arrange
        item = {"pk": "1", "count": 5}
        expected_count = 5

        # Act
        result = apply_update_expression(
            item,
            "SET count = if_not_exists(count, :default)",
            expression_values={":default": {"N": "0"}},
        )

        # Assert
        actual_count = result["count"]
        assert actual_count == expected_count

    def test_if_not_exists_with_arithmetic(self) -> None:
        # Arrange
        item = {"pk": "1"}
        expected_count = 1

        # Act
        result = apply_update_expression(
            item,
            "SET count = if_not_exists(count, :zero) + :inc",
            expression_values={":zero": {"N": "0"}, ":inc": {"N": "1"}},
        )

        # Assert
        actual_count = result["count"]
        assert actual_count == expected_count
