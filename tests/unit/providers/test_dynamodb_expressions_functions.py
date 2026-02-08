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


class TestFunctions:
    """Test attribute_exists, attribute_not_exists, begins_with, contains, size."""

    def test_attribute_exists_true(self) -> None:
        item = {"name": "Alice"}
        assert evaluate_filter_expression(item, "attribute_exists(name)")

    def test_attribute_exists_false(self) -> None:
        item = {"name": "Alice"}
        assert not evaluate_filter_expression(item, "attribute_exists(age)")

    def test_attribute_not_exists_true(self) -> None:
        item = {"name": "Alice"}
        assert evaluate_filter_expression(item, "attribute_not_exists(age)")

    def test_attribute_not_exists_false(self) -> None:
        item = {"name": "Alice"}
        assert not evaluate_filter_expression(item, "attribute_not_exists(name)")

    def test_attribute_exists_with_name_ref(self) -> None:
        item = {"status": "active"}
        assert evaluate_filter_expression(
            item,
            "attribute_exists(#s)",
            expression_names={"#s": "status"},
        )

    def test_begins_with_true(self) -> None:
        item = {"name": "Alice"}
        assert evaluate_filter_expression(
            item,
            "begins_with(name, :prefix)",
            expression_values={":prefix": {"S": "Al"}},
        )

    def test_begins_with_false(self) -> None:
        item = {"name": "Alice"}
        assert not evaluate_filter_expression(
            item,
            "begins_with(name, :prefix)",
            expression_values={":prefix": {"S": "Bo"}},
        )

    def test_contains_string(self) -> None:
        item = {"name": "Alice in Wonderland"}
        assert evaluate_filter_expression(
            item,
            "contains(name, :sub)",
            expression_values={":sub": {"S": "Wonder"}},
        )

    def test_contains_string_false(self) -> None:
        item = {"name": "Alice"}
        assert not evaluate_filter_expression(
            item,
            "contains(name, :sub)",
            expression_values={":sub": {"S": "Bob"}},
        )

    def test_contains_list(self) -> None:
        item = {"tags": ["python", "aws", "dynamodb"]}
        assert evaluate_filter_expression(
            item,
            "contains(tags, :tag)",
            expression_values={":tag": {"S": "aws"}},
        )

    def test_size_string(self) -> None:
        item = {"name": "Alice"}
        assert evaluate_filter_expression(
            item,
            "size(name) = :v",
            expression_values={":v": {"N": "5"}},
        )

    def test_size_list(self) -> None:
        item = {"tags": ["a", "b", "c"]}
        assert evaluate_filter_expression(
            item,
            "size(tags) > :v",
            expression_values={":v": {"N": "2"}},
        )

    def test_size_missing_attr(self) -> None:
        item = {"name": "Alice"}
        # size of missing attribute is 0
        assert evaluate_filter_expression(
            item,
            "size(tags) = :v",
            expression_values={":v": {"N": "0"}},
        )
