"""Tests for the Step Functions choice evaluator and path utilities.

Covers all comparison operators, logical combinators (And/Or/Not),
type-checking operators, and JSONPath-like path processing.
"""

from __future__ import annotations

from lws.providers.stepfunctions.path_utils import (
    apply_parameters,
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


class TestApplyParameters:
    """Parameters template processing."""

    def test_static_values(self) -> None:
        result = apply_parameters({"key": "value"}, {})
        assert result == {"key": "value"}, "Expected {!r} but got {!r}".format(
            {"key": "value"}, result
        )

    def test_jsonpath_reference(self) -> None:
        result = apply_parameters({"name.$": "$.user"}, {"user": "Alice"})
        assert result == {"name": "Alice"}, "Expected {!r} but got {!r}".format(
            {"name": "Alice"}, result
        )

    def test_mixed_static_and_dynamic(self) -> None:
        params = {"greeting": "hello", "name.$": "$.user"}
        result = apply_parameters(params, {"user": "Bob"})
        assert result == {"greeting": "hello", "name": "Bob"}, "Expected {!r} but got {!r}".format(
            {"greeting": "hello", "name": "Bob"}, result
        )

    def test_nested_parameters(self) -> None:
        params = {"outer": {"inner.$": "$.val"}}
        result = apply_parameters(params, {"val": 42})
        assert result == {"outer": {"inner": 42}}, "Expected {!r} but got {!r}".format(
            {"outer": {"inner": 42}}, result
        )
