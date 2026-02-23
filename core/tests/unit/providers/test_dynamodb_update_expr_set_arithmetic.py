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


class TestSetArithmetic:
    """Test SET with arithmetic (+, -)."""

    def test_add_to_number(self) -> None:
        # Arrange
        item = {"pk": "1", "count": 10}
        expected_count = 15

        # Act
        result = apply_update_expression(
            item,
            "SET count = count + :inc",
            expression_values={":inc": {"N": "5"}},
        )

        # Assert
        actual_count = result["count"]
        assert actual_count == expected_count

    def test_subtract_from_number(self) -> None:
        # Arrange
        item = {"pk": "1", "count": 10}
        expected_count = 7

        # Act
        result = apply_update_expression(
            item,
            "SET count = count - :dec",
            expression_values={":dec": {"N": "3"}},
        )

        # Assert
        actual_count = result["count"]
        assert actual_count == expected_count

    def test_add_with_value_refs(self) -> None:
        # Arrange
        item = {"pk": "1", "price": 100}
        expected_price = 115

        # Act
        result = apply_update_expression(
            item,
            "SET price = price + :tax",
            expression_values={":tax": {"N": "15"}},
        )

        # Assert
        actual_price = result["price"]
        assert actual_price == expected_price
