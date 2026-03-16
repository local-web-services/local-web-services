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


class TestSetAssignment:
    """Test basic SET assignments."""

    def test_set_simple_string(self) -> None:
        # Arrange
        item = {"pk": "1", "name": "Alice"}
        expected_name = "Bob"

        # Act
        result = apply_update_expression(
            item,
            "SET name = :v",
            expression_values={":v": {"S": "Bob"}},
        )

        # Assert
        actual_name = result["name"]
        assert actual_name == expected_name

    def test_set_number(self) -> None:
        # Arrange
        item = {"pk": "1", "count": 5}
        expected_count = 10

        # Act
        result = apply_update_expression(
            item,
            "SET count = :v",
            expression_values={":v": {"N": "10"}},
        )

        # Assert
        actual_count = result["count"]
        assert actual_count == expected_count

    def test_set_new_attribute(self) -> None:
        # Arrange
        item = {"pk": "1"}
        expected_color = "red"

        # Act
        result = apply_update_expression(
            item,
            "SET color = :v",
            expression_values={":v": {"S": "red"}},
        )

        # Assert
        actual_color = result["color"]
        assert actual_color == expected_color

    def test_set_multiple_attributes(self) -> None:
        # Arrange
        item = {"pk": "1"}
        expected_a = "alpha"
        expected_b = "beta"

        # Act
        result = apply_update_expression(
            item,
            "SET a = :a, b = :b",
            expression_values={":a": {"S": "alpha"}, ":b": {"S": "beta"}},
        )

        # Assert
        actual_a = result["a"]
        actual_b = result["b"]
        assert actual_a == expected_a
        assert actual_b == expected_b

    def test_set_with_name_ref(self) -> None:
        # Arrange
        item = {"pk": "1", "reserved": "old"}
        expected_reserved = "new"

        # Act
        result = apply_update_expression(
            item,
            "SET #r = :v",
            expression_names={"#r": "reserved"},
            expression_values={":v": {"S": "new"}},
        )

        # Assert
        actual_reserved = result["reserved"]
        assert actual_reserved == expected_reserved
