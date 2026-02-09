"""Tests for the Step Functions choice evaluator and path utilities.

Covers all comparison operators, logical combinators (And/Or/Not),
type-checking operators, and JSONPath-like path processing.
"""

from __future__ import annotations

from lws.providers.stepfunctions.path_utils import (
    apply_context_parameters,
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


class TestApplyContextParameters:
    """Parameters template with context object ($$ references)."""

    def test_context_reference(self) -> None:
        params = {"index.$": "$$.Map.Item.Index"}
        context = {"Map": {"Item": {"Index": 0}}}
        result = apply_context_parameters(params, {}, context)
        assert result == {"index": 0}

    def test_mixed_input_and_context(self) -> None:
        params = {
            "val.$": "$.data",
            "idx.$": "$$.Map.Item.Index",
        }
        context = {"Map": {"Item": {"Index": 3}}}
        result = apply_context_parameters(params, {"data": "hello"}, context)
        assert result == {"val": "hello", "idx": 3}
