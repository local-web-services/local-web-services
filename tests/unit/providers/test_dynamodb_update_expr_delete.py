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


class TestDelete:
    """Test DELETE clause: remove elements from a set."""

    def test_delete_from_string_set(self) -> None:
        # Arrange
        item = {"pk": "1", "tags": {"python", "aws", "dynamodb"}}
        expected_tags = {"python", "dynamodb"}

        # Act
        result = apply_update_expression(
            item,
            "DELETE tags :rem",
            expression_values={":rem": {"SS": ["aws"]}},
        )

        # Assert
        actual_tags = result["tags"]
        assert actual_tags == expected_tags

    def test_delete_from_number_set(self) -> None:
        # Arrange
        item = {"pk": "1", "numbers": {1, 2, 3, 4, 5}}
        expected_numbers = {1, 3, 5}

        # Act
        result = apply_update_expression(
            item,
            "DELETE numbers :rem",
            expression_values={":rem": {"NS": ["2", "4"]}},
        )

        # Assert
        actual_numbers = result["numbers"]
        assert actual_numbers == expected_numbers

    def test_delete_nonexistent_elements(self) -> None:
        # Arrange
        item = {"pk": "1", "tags": {"python", "aws"}}
        expected_tags = {"python", "aws"}

        # Act
        result = apply_update_expression(
            item,
            "DELETE tags :rem",
            expression_values={":rem": {"SS": ["nonexistent"]}},
        )

        # Assert
        actual_tags = result["tags"]
        assert actual_tags == expected_tags

    def test_delete_from_missing_attribute(self) -> None:
        item = {"pk": "1"}
        result = apply_update_expression(
            item,
            "DELETE tags :rem",
            expression_values={":rem": {"SS": ["a"]}},
        )
        # No error, attribute just not there
        assert "tags" not in result
