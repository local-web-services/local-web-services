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


class TestStringOperators:
    """String comparison operators."""

    def test_string_equals_true(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.s",
            comparison_operator="StringEquals",
            comparison_value="hello",
        )
        assert evaluate_rule(rule, {"s": "hello"}) is True, "Expected value to be truthy"

    def test_string_equals_false(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.s",
            comparison_operator="StringEquals",
            comparison_value="hello",
        )
        assert evaluate_rule(rule, {"s": "world"}) is False, "Expected value to be truthy"

    def test_string_greater_than(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.s",
            comparison_operator="StringGreaterThan",
            comparison_value="abc",
        )
        assert evaluate_rule(rule, {"s": "xyz"}) is True, "Expected value to be truthy"
        assert evaluate_rule(rule, {"s": "aaa"}) is False, "Expected value to be truthy"

    def test_string_less_than(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.s",
            comparison_operator="StringLessThan",
            comparison_value="m",
        )
        assert evaluate_rule(rule, {"s": "a"}) is True, "Expected value to be truthy"
        assert evaluate_rule(rule, {"s": "z"}) is False, "Expected value to be truthy"

    def test_string_greater_than_equals(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.s",
            comparison_operator="StringGreaterThanEquals",
            comparison_value="hello",
        )
        assert evaluate_rule(rule, {"s": "hello"}) is True, "Expected value to be truthy"
        assert evaluate_rule(rule, {"s": "world"}) is True, "Expected value to be truthy"
        assert evaluate_rule(rule, {"s": "abc"}) is False, "Expected value to be truthy"

    def test_string_less_than_equals(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.s",
            comparison_operator="StringLessThanEquals",
            comparison_value="hello",
        )
        assert evaluate_rule(rule, {"s": "hello"}) is True, "Expected value to be truthy"
        assert evaluate_rule(rule, {"s": "abc"}) is True, "Expected value to be truthy"
        assert evaluate_rule(rule, {"s": "world"}) is False, "Expected value to be truthy"

    def test_string_operator_with_non_string(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.s",
            comparison_operator="StringEquals",
            comparison_value="hello",
        )
        assert evaluate_rule(rule, {"s": 123}) is False, "Expected value to be truthy"
