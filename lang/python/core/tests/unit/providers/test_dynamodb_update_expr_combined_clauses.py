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


class TestCombinedClauses:
    """Test combined SET, REMOVE, ADD, DELETE in a single expression."""

    def test_set_and_remove(self) -> None:
        # Arrange
        item = {"pk": "1", "a": 1, "b": 2}
        expected_a = 99

        # Act
        result = apply_update_expression(
            item,
            "SET a = :v REMOVE b",
            expression_values={":v": {"N": "99"}},
        )

        # Assert
        actual_a = result["a"]
        assert actual_a == expected_a, f"Expected {expected_a!r} but got {actual_a!r}"
        assert "b" not in result, f'Expected {"b"!r} to not be in {result!r}'

    def test_set_remove_add(self) -> None:
        # Arrange
        item = {"pk": "1", "name": "old", "temp": "gone", "count": 5}
        expected_name = "new"
        expected_count = 6

        # Act
        result = apply_update_expression(
            item,
            "SET name = :n REMOVE temp ADD count :inc",
            expression_values={":n": {"S": "new"}, ":inc": {"N": "1"}},
        )

        # Assert
        actual_name = result["name"]
        actual_count = result["count"]
        assert actual_name == expected_name, f"Expected {expected_name!r} but got {actual_name!r}"
        assert "temp" not in result, f'Expected {"temp"!r} to not be in {result!r}'
        assert actual_count == expected_count, f"Expected {expected_count!r} but got {actual_count!r}"

    def test_all_four_clauses(self) -> None:
        # Arrange
        item = {
            "pk": "1",
            "name": "old",
            "temp": "gone",
            "count": 10,
            "tags": {"a", "b", "c"},
        }
        expected_name = "new"
        expected_count = 15
        expected_tags = {"a", "c"}

        # Act
        result = apply_update_expression(
            item,
            "SET name = :n REMOVE temp ADD count :inc DELETE tags :rem",
            expression_values={
                ":n": {"S": "new"},
                ":inc": {"N": "5"},
                ":rem": {"SS": ["b"]},
            },
        )

        # Assert
        actual_name = result["name"]
        actual_count = result["count"]
        actual_tags = result["tags"]
        assert actual_name == expected_name, f"Expected {expected_name!r} but got {actual_name!r}"
        assert "temp" not in result, f'Expected {"temp"!r} to not be in {result!r}'
        assert actual_count == expected_count, f"Expected {expected_count!r} but got {actual_count!r}"
        assert actual_tags == expected_tags, f"Expected {expected_tags!r} but got {actual_tags!r}"
