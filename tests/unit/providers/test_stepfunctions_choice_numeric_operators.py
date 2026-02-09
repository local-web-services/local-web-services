"""Tests for the Step Functions choice evaluator and path utilities.

Covers all comparison operators, logical combinators (And/Or/Not),
type-checking operators, and JSONPath-like path processing.
"""

from __future__ import annotations

from lws.providers.stepfunctions.asl_parser import ChoiceRule
from lws.providers.stepfunctions.choice_evaluator import (
    evaluate_rule,
)

# ---------------------------------------------------------------------------
# Path utilities
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Choice evaluator - String operators
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Numeric operators
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Boolean operator
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Type-checking operators
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Logical combinators
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# evaluate_choice_rules
# ---------------------------------------------------------------------------


class TestNumericOperators:
    """Numeric comparison operators."""

    def test_numeric_equals(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.n",
            comparison_operator="NumericEquals",
            comparison_value=42,
        )
        assert evaluate_rule(rule, {"n": 42}) is True
        assert evaluate_rule(rule, {"n": 43}) is False

    def test_numeric_greater_than(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.n",
            comparison_operator="NumericGreaterThan",
            comparison_value=10,
        )
        assert evaluate_rule(rule, {"n": 20}) is True
        assert evaluate_rule(rule, {"n": 5}) is False

    def test_numeric_less_than(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.n",
            comparison_operator="NumericLessThan",
            comparison_value=10,
        )
        assert evaluate_rule(rule, {"n": 5}) is True
        assert evaluate_rule(rule, {"n": 15}) is False

    def test_numeric_greater_than_equals(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.n",
            comparison_operator="NumericGreaterThanEquals",
            comparison_value=10,
        )
        assert evaluate_rule(rule, {"n": 10}) is True
        assert evaluate_rule(rule, {"n": 11}) is True
        assert evaluate_rule(rule, {"n": 9}) is False

    def test_numeric_less_than_equals(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.n",
            comparison_operator="NumericLessThanEquals",
            comparison_value=10,
        )
        assert evaluate_rule(rule, {"n": 10}) is True
        assert evaluate_rule(rule, {"n": 9}) is True
        assert evaluate_rule(rule, {"n": 11}) is False

    def test_numeric_with_float(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.n",
            comparison_operator="NumericGreaterThan",
            comparison_value=1.5,
        )
        assert evaluate_rule(rule, {"n": 2.0}) is True
        assert evaluate_rule(rule, {"n": 1.0}) is False

    def test_numeric_with_non_number(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.n",
            comparison_operator="NumericEquals",
            comparison_value=42,
        )
        assert evaluate_rule(rule, {"n": "42"}) is False
