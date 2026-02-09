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


class TestTypeCheckOperators:
    """IsPresent, IsNull, IsString, IsNumeric, IsBoolean operators."""

    def test_is_present_true(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.x",
            comparison_operator="IsPresent",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"x": 1}) is True

    def test_is_present_false_when_missing(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.x",
            comparison_operator="IsPresent",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"y": 1}) is False

    def test_is_present_inverted(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.x",
            comparison_operator="IsPresent",
            comparison_value=False,
        )
        assert evaluate_rule(rule, {"y": 1}) is True

    def test_is_null_true(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.x",
            comparison_operator="IsNull",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"x": None}) is True
        assert evaluate_rule(rule, {"x": 1}) is False

    def test_is_string(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.x",
            comparison_operator="IsString",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"x": "hello"}) is True
        assert evaluate_rule(rule, {"x": 123}) is False

    def test_is_numeric(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.x",
            comparison_operator="IsNumeric",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"x": 42}) is True
        assert evaluate_rule(rule, {"x": 3.14}) is True
        assert evaluate_rule(rule, {"x": "42"}) is False
        assert evaluate_rule(rule, {"x": True}) is False

    def test_is_boolean(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.x",
            comparison_operator="IsBoolean",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"x": True}) is True
        assert evaluate_rule(rule, {"x": False}) is True
        assert evaluate_rule(rule, {"x": 1}) is False
