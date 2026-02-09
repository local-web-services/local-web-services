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


class TestLogicalCombinators:
    """And, Or, Not combinators."""

    def test_and_all_true(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            and_rules=[
                ChoiceRule(
                    next_state="",
                    variable="$.a",
                    comparison_operator="NumericGreaterThan",
                    comparison_value=0,
                ),
                ChoiceRule(
                    next_state="",
                    variable="$.b",
                    comparison_operator="NumericGreaterThan",
                    comparison_value=0,
                ),
            ],
        )
        assert evaluate_rule(rule, {"a": 1, "b": 2}) is True

    def test_and_one_false(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            and_rules=[
                ChoiceRule(
                    next_state="",
                    variable="$.a",
                    comparison_operator="NumericGreaterThan",
                    comparison_value=0,
                ),
                ChoiceRule(
                    next_state="",
                    variable="$.b",
                    comparison_operator="NumericGreaterThan",
                    comparison_value=0,
                ),
            ],
        )
        assert evaluate_rule(rule, {"a": 1, "b": -1}) is False

    def test_or_one_true(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            or_rules=[
                ChoiceRule(
                    next_state="",
                    variable="$.a",
                    comparison_operator="StringEquals",
                    comparison_value="yes",
                ),
                ChoiceRule(
                    next_state="",
                    variable="$.b",
                    comparison_operator="StringEquals",
                    comparison_value="yes",
                ),
            ],
        )
        assert evaluate_rule(rule, {"a": "no", "b": "yes"}) is True

    def test_or_none_true(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            or_rules=[
                ChoiceRule(
                    next_state="",
                    variable="$.a",
                    comparison_operator="StringEquals",
                    comparison_value="yes",
                ),
                ChoiceRule(
                    next_state="",
                    variable="$.b",
                    comparison_operator="StringEquals",
                    comparison_value="yes",
                ),
            ],
        )
        assert evaluate_rule(rule, {"a": "no", "b": "no"}) is False

    def test_not_inverts(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            not_rule=ChoiceRule(
                next_state="",
                variable="$.x",
                comparison_operator="NumericEquals",
                comparison_value=0,
            ),
        )
        assert evaluate_rule(rule, {"x": 5}) is True
        assert evaluate_rule(rule, {"x": 0}) is False
