"""Tests for DynamoDB UpdateExpression evaluator (P1-24)."""

from __future__ import annotations

from ldk.providers.dynamodb.update_expression import (
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
        item = {"pk": "1", "a": 1, "b": 2}
        result = apply_update_expression(
            item,
            "SET a = :v REMOVE b",
            expression_values={":v": {"N": "99"}},
        )
        assert result["a"] == 99
        assert "b" not in result

    def test_set_remove_add(self) -> None:
        item = {"pk": "1", "name": "old", "temp": "gone", "count": 5}
        result = apply_update_expression(
            item,
            "SET name = :n REMOVE temp ADD count :inc",
            expression_values={":n": {"S": "new"}, ":inc": {"N": "1"}},
        )
        assert result["name"] == "new"
        assert "temp" not in result
        assert result["count"] == 6

    def test_all_four_clauses(self) -> None:
        item = {
            "pk": "1",
            "name": "old",
            "temp": "gone",
            "count": 10,
            "tags": {"a", "b", "c"},
        }
        result = apply_update_expression(
            item,
            "SET name = :n REMOVE temp ADD count :inc DELETE tags :rem",
            expression_values={
                ":n": {"S": "new"},
                ":inc": {"N": "5"},
                ":rem": {"SS": ["b"]},
            },
        )
        assert result["name"] == "new"
        assert "temp" not in result
        assert result["count"] == 15
        assert result["tags"] == {"a", "c"}
