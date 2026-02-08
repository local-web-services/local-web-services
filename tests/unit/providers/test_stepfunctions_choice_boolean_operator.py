"""Tests for the Step Functions choice evaluator and path utilities.

Covers all comparison operators, logical combinators (And/Or/Not),
type-checking operators, and JSONPath-like path processing.
"""

from __future__ import annotations

from ldk.providers.stepfunctions.asl_parser import ChoiceRule
from ldk.providers.stepfunctions.choice_evaluator import (
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


class TestBooleanOperator:
    """BooleanEquals operator."""

    def test_boolean_equals_true(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.b",
            comparison_operator="BooleanEquals",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"b": True}) is True
        assert evaluate_rule(rule, {"b": False}) is False

    def test_boolean_equals_false(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.b",
            comparison_operator="BooleanEquals",
            comparison_value=False,
        )
        assert evaluate_rule(rule, {"b": False}) is True
        assert evaluate_rule(rule, {"b": True}) is False

    def test_boolean_with_non_bool(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.b",
            comparison_operator="BooleanEquals",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"b": 1}) is False
