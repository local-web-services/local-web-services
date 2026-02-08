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


class TestComparisonOperators:
    """Test all comparison operators: =, <>, <, >, <=, >=."""

    def test_equals(self) -> None:
        item = {"age": 30}
        assert evaluate_filter_expression(item, "age = :v", expression_values={":v": {"N": "30"}})

    def test_not_equals(self) -> None:
        item = {"age": 30}
        assert evaluate_filter_expression(item, "age <> :v", expression_values={":v": {"N": "25"}})

    def test_less_than(self) -> None:
        item = {"age": 20}
        assert evaluate_filter_expression(item, "age < :v", expression_values={":v": {"N": "30"}})

    def test_less_than_false(self) -> None:
        item = {"age": 40}
        assert not evaluate_filter_expression(
            item, "age < :v", expression_values={":v": {"N": "30"}}
        )

    def test_greater_than(self) -> None:
        item = {"age": 40}
        assert evaluate_filter_expression(item, "age > :v", expression_values={":v": {"N": "30"}})

    def test_less_than_or_equal(self) -> None:
        item = {"age": 30}
        assert evaluate_filter_expression(item, "age <= :v", expression_values={":v": {"N": "30"}})

    def test_greater_than_or_equal(self) -> None:
        item = {"age": 30}
        assert evaluate_filter_expression(item, "age >= :v", expression_values={":v": {"N": "30"}})

    def test_string_equals(self) -> None:
        item = {"name": "Alice"}
        assert evaluate_filter_expression(
            item, "name = :v", expression_values={":v": {"S": "Alice"}}
        )

    def test_string_not_equals(self) -> None:
        item = {"name": "Alice"}
        assert evaluate_filter_expression(
            item, "name <> :v", expression_values={":v": {"S": "Bob"}}
        )

    def test_missing_attribute_returns_false(self) -> None:
        item = {"name": "Alice"}
        assert not evaluate_filter_expression(
            item, "age = :v", expression_values={":v": {"N": "30"}}
        )
