"""Tests for the Step Functions choice evaluator and path utilities.

Covers all comparison operators, logical combinators (And/Or/Not),
type-checking operators, and JSONPath-like path processing.
"""

from __future__ import annotations

from lws.providers.stepfunctions.asl_parser import ChoiceRule
from lws.providers.stepfunctions.choice_evaluator import (
    evaluate_choice_rules,
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


class TestEvaluateChoiceRules:
    """Evaluating a list of choice rules."""

    def test_first_matching_rule_wins(self) -> None:
        rules = [
            ChoiceRule(
                next_state="First",
                variable="$.x",
                comparison_operator="NumericGreaterThan",
                comparison_value=0,
            ),
            ChoiceRule(
                next_state="Second",
                variable="$.x",
                comparison_operator="NumericGreaterThan",
                comparison_value=-10,
            ),
        ]
        result = evaluate_choice_rules(rules, {"x": 5})
        assert result == "First"

    def test_no_match_returns_none(self) -> None:
        rules = [
            ChoiceRule(
                next_state="Match",
                variable="$.x",
                comparison_operator="StringEquals",
                comparison_value="nope",
            ),
        ]
        result = evaluate_choice_rules(rules, {"x": "different"})
        assert result is None

    def test_empty_rules_returns_none(self) -> None:
        result = evaluate_choice_rules([], {"x": 1})
        assert result is None

    def test_missing_variable_returns_false(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.missing",
            comparison_operator="NumericEquals",
            comparison_value=1,
        )
        assert evaluate_rule(rule, {"x": 1}) is False
