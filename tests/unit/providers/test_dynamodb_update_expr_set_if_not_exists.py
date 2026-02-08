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


class TestSetIfNotExists:
    """Test SET with if_not_exists function."""

    def test_if_not_exists_attribute_missing(self) -> None:
        item = {"pk": "1"}
        result = apply_update_expression(
            item,
            "SET count = if_not_exists(count, :default)",
            expression_values={":default": {"N": "0"}},
        )
        assert result["count"] == 0

    def test_if_not_exists_attribute_present(self) -> None:
        item = {"pk": "1", "count": 5}
        result = apply_update_expression(
            item,
            "SET count = if_not_exists(count, :default)",
            expression_values={":default": {"N": "0"}},
        )
        assert result["count"] == 5

    def test_if_not_exists_with_arithmetic(self) -> None:
        item = {"pk": "1"}
        result = apply_update_expression(
            item,
            "SET count = if_not_exists(count, :zero) + :inc",
            expression_values={":zero": {"N": "0"}, ":inc": {"N": "1"}},
        )
        assert result["count"] == 1
