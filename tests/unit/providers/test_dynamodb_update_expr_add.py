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


class TestAdd:
    """Test ADD clause: add to number or set."""

    def test_add_to_number(self) -> None:
        # Arrange
        item = {"pk": "1", "count": 10}
        expected_count = 15

        # Act
        result = apply_update_expression(
            item,
            "ADD count :inc",
            expression_values={":inc": {"N": "5"}},
        )

        # Assert
        actual_count = result["count"]
        assert actual_count == expected_count

    def test_add_creates_number_if_missing(self) -> None:
        # Arrange
        item = {"pk": "1"}
        expected_count = 1

        # Act
        result = apply_update_expression(
            item,
            "ADD count :v",
            expression_values={":v": {"N": "1"}},
        )

        # Assert
        actual_count = result["count"]
        assert actual_count == expected_count

    def test_add_to_set(self) -> None:
        # Arrange
        item = {"pk": "1", "tags": {"python", "aws"}}
        expected_tags = {"python", "aws", "dynamodb"}

        # Act
        result = apply_update_expression(
            item,
            "ADD tags :new",
            expression_values={":new": {"SS": ["dynamodb"]}},
        )

        # Assert
        actual_tags = result["tags"]
        assert actual_tags == expected_tags

    def test_add_creates_set_if_missing(self) -> None:
        # Arrange
        item = {"pk": "1"}
        expected_tags = {"hello"}

        # Act
        result = apply_update_expression(
            item,
            "ADD tags :new",
            expression_values={":new": {"SS": ["hello"]}},
        )

        # Assert
        actual_tags = result["tags"]
        assert actual_tags == expected_tags

    def test_add_number_set(self) -> None:
        # Arrange
        item = {"pk": "1", "numbers": {1, 2, 3}}
        expected_numbers = {1, 2, 3, 4, 5}

        # Act
        result = apply_update_expression(
            item,
            "ADD numbers :new",
            expression_values={":new": {"NS": ["4", "5"]}},
        )

        # Assert
        actual_numbers = result["numbers"]
        assert actual_numbers == expected_numbers
