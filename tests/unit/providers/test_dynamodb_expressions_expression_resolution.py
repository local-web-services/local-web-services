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


class TestExpressionResolution:
    """Test #name and :value resolution."""

    def test_name_ref_resolution(self) -> None:
        item = {"reserved_word": "hello"}
        assert evaluate_filter_expression(
            item,
            "#rw = :v",
            expression_names={"#rw": "reserved_word"},
            expression_values={":v": {"S": "hello"}},
        )

    def test_value_ref_resolution_number(self) -> None:
        item = {"count": 42}
        assert evaluate_filter_expression(
            item,
            "count = :c",
            expression_values={":c": {"N": "42"}},
        )

    def test_value_ref_resolution_bool(self) -> None:
        item = {"active": True}
        assert evaluate_filter_expression(
            item,
            "active = :v",
            expression_values={":v": {"BOOL": True}},
        )

    def test_combined_names_and_values(self) -> None:
        item = {"status": "active", "age": 30}
        assert evaluate_filter_expression(
            item,
            "#s = :sv AND #a > :av",
            expression_names={"#s": "status", "#a": "age"},
            expression_values={":sv": {"S": "active"}, ":av": {"N": "20"}},
        )
