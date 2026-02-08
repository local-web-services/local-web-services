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


class TestAdd:
    """Test ADD clause: add to number or set."""

    def test_add_to_number(self) -> None:
        item = {"pk": "1", "count": 10}
        result = apply_update_expression(
            item,
            "ADD count :inc",
            expression_values={":inc": {"N": "5"}},
        )
        assert result["count"] == 15

    def test_add_creates_number_if_missing(self) -> None:
        item = {"pk": "1"}
        result = apply_update_expression(
            item,
            "ADD count :v",
            expression_values={":v": {"N": "1"}},
        )
        assert result["count"] == 1

    def test_add_to_set(self) -> None:
        item = {"pk": "1", "tags": {"python", "aws"}}
        result = apply_update_expression(
            item,
            "ADD tags :new",
            expression_values={":new": {"SS": ["dynamodb"]}},
        )
        assert result["tags"] == {"python", "aws", "dynamodb"}

    def test_add_creates_set_if_missing(self) -> None:
        item = {"pk": "1"}
        result = apply_update_expression(
            item,
            "ADD tags :new",
            expression_values={":new": {"SS": ["hello"]}},
        )
        assert result["tags"] == {"hello"}

    def test_add_number_set(self) -> None:
        item = {"pk": "1", "numbers": {1, 2, 3}}
        result = apply_update_expression(
            item,
            "ADD numbers :new",
            expression_values={":new": {"NS": ["4", "5"]}},
        )
        assert result["numbers"] == {1, 2, 3, 4, 5}
