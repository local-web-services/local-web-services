"""Tests for DynamoDB FilterExpression evaluator (P1-23)."""

from __future__ import annotations

from ldk.providers.dynamodb.expressions import (
    evaluate_filter_expression,
)

# ---------------------------------------------------------------------------
# Tokenizer tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Comparison operator tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Logical operator tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# BETWEEN and IN tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Function tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Expression name/value resolution tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# apply_filter_expression tests
# ---------------------------------------------------------------------------


class TestBetweenAndIn:
    """Test BETWEEN and IN operators."""

    def test_between_in_range(self) -> None:
        item = {"age": 25}
        assert evaluate_filter_expression(
            item,
            "age BETWEEN :lo AND :hi",
            expression_values={":lo": {"N": "20"}, ":hi": {"N": "30"}},
        )

    def test_between_at_boundary(self) -> None:
        item = {"age": 20}
        assert evaluate_filter_expression(
            item,
            "age BETWEEN :lo AND :hi",
            expression_values={":lo": {"N": "20"}, ":hi": {"N": "30"}},
        )

    def test_between_out_of_range(self) -> None:
        item = {"age": 35}
        assert not evaluate_filter_expression(
            item,
            "age BETWEEN :lo AND :hi",
            expression_values={":lo": {"N": "20"}, ":hi": {"N": "30"}},
        )

    def test_in_found(self) -> None:
        item = {"status": "active"}
        assert evaluate_filter_expression(
            item,
            "status IN (:a, :b, :c)",
            expression_values={":a": {"S": "active"}, ":b": {"S": "pending"}, ":c": {"S": "done"}},
        )

    def test_in_not_found(self) -> None:
        item = {"status": "deleted"}
        assert not evaluate_filter_expression(
            item,
            "status IN (:a, :b)",
            expression_values={":a": {"S": "active"}, ":b": {"S": "pending"}},
        )
