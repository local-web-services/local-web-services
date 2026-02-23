"""Tests for DynamoDB FilterExpression evaluator (P1-23)."""

from __future__ import annotations

from lws.providers.dynamodb.expressions import (
    apply_filter_expression,
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


class TestApplyFilterExpression:
    """Test the batch filtering function."""

    def test_none_expression_returns_all(self) -> None:
        items = [{"a": 1}, {"a": 2}]
        assert apply_filter_expression(items, None) == items

    def test_empty_expression_returns_all(self) -> None:
        items = [{"a": 1}, {"a": 2}]
        assert apply_filter_expression(items, "") == items

    def test_filters_items(self) -> None:
        # Arrange
        items = [
            {"name": "Alice", "age": 30},
            {"name": "Bob", "age": 25},
            {"name": "Charlie", "age": 35},
        ]
        expected_count = 2
        expected_names = {"Alice", "Charlie"}

        # Act
        result = apply_filter_expression(
            items,
            "age > :min",
            expression_values={":min": {"N": "28"}},
        )

        # Assert
        assert len(result) == expected_count
        actual_names = {r["name"] for r in result}
        assert actual_names == expected_names

    def test_complex_filter(self) -> None:
        # Arrange
        items = [
            {"name": "Alice", "age": 30, "active": True},
            {"name": "Bob", "age": 25, "active": False},
            {"name": "Charlie", "age": 35, "active": True},
        ]
        expected_count = 2
        expected_names = {"Alice", "Charlie"}

        # Act
        result = apply_filter_expression(
            items,
            "active = :t AND age >= :min",
            expression_values={":t": {"BOOL": True}, ":min": {"N": "30"}},
        )

        # Assert
        assert len(result) == expected_count
        actual_names = {r["name"] for r in result}
        assert actual_names == expected_names
