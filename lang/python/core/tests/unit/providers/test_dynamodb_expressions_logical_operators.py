"""Tests for DynamoDB FilterExpression evaluator (P1-23)."""

from __future__ import annotations

from lws.providers.dynamodb.expressions import (
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


class TestLogicalOperators:
    """Test AND, OR, NOT with proper precedence."""

    def test_and_both_true(self) -> None:
        item = {"age": 30, "name": "Alice"}
        assert evaluate_filter_expression(
            item,
            "age = :age AND name = :name",
            expression_values={":age": {"N": "30"}, ":name": {"S": "Alice"}},
        )

    def test_and_one_false(self) -> None:
        item = {"age": 30, "name": "Alice"}
        assert not evaluate_filter_expression(
            item,
            "age = :age AND name = :name",
            expression_values={":age": {"N": "30"}, ":name": {"S": "Bob"}},
        )

    def test_or_one_true(self) -> None:
        item = {"age": 30, "name": "Alice"}
        assert evaluate_filter_expression(
            item,
            "age = :age OR name = :name",
            expression_values={":age": {"N": "99"}, ":name": {"S": "Alice"}},
        )

    def test_or_both_false(self) -> None:
        item = {"age": 30, "name": "Alice"}
        assert not evaluate_filter_expression(
            item,
            "age = :age OR name = :name",
            expression_values={":age": {"N": "99"}, ":name": {"S": "Bob"}},
        )

    def test_not(self) -> None:
        item = {"active": True}
        # NOT (active = :false) should be True since active != false
        assert evaluate_filter_expression(
            item,
            "NOT active = :v",
            expression_values={":v": {"BOOL": False}},
        )

    def test_not_negation(self) -> None:
        item = {"active": True}
        assert not evaluate_filter_expression(
            item,
            "NOT active = :v",
            expression_values={":v": {"BOOL": True}},
        )

    def test_precedence_and_before_or(self) -> None:
        """AND binds tighter than OR: a OR (b AND c)."""
        item = {"x": 1, "y": 2, "z": 3}
        # x=99 is false, y=2 AND z=3 is true, so OR yields true
        assert evaluate_filter_expression(
            item,
            "x = :a OR y = :b AND z = :c",
            expression_values={":a": {"N": "99"}, ":b": {"N": "2"}, ":c": {"N": "3"}},
        )

    def test_precedence_and_before_or_both_false(self) -> None:
        """x=99 false OR (y=2 AND z=99) false => false."""
        item = {"x": 1, "y": 2, "z": 3}
        assert not evaluate_filter_expression(
            item,
            "x = :a OR y = :b AND z = :c",
            expression_values={":a": {"N": "99"}, ":b": {"N": "2"}, ":c": {"N": "99"}},
        )
