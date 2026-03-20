"""Tests for the Step Functions choice evaluator and path utilities.

Covers all comparison operators, logical combinators (And/Or/Not),
type-checking operators, and JSONPath-like path processing.
"""

from __future__ import annotations

from lws.providers.stepfunctions.path_utils import (
    apply_result_path,
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


class TestApplyResultPath:
    """ResultPath processing."""

    def test_null_discards_result(self) -> None:
        original = {"x": 1}
        result = apply_result_path(original, "discarded", None)
        assert result == {"x": 1}, "Expected {!r} but got {!r}".format({"x": 1}, result)

    def test_root_replaces_input(self) -> None:
        result = apply_result_path({"x": 1}, {"y": 2}, "$")
        assert result == {"y": 2}, "Expected {!r} but got {!r}".format({"y": 2}, result)

    def test_nested_path_sets_value(self) -> None:
        result = apply_result_path({"x": 1}, "hello", "$.greeting")
        assert result == {"x": 1, "greeting": "hello"}, "Expected {!r} but got {!r}".format(
            {"x": 1, "greeting": "hello"}, result
        )

    def test_deep_nested_path(self) -> None:
        result = apply_result_path({"x": 1}, "val", "$.a.b")
        assert result["a"]["b"] == "val", f'Expected {"val"!r} but got {result["a"]["b"]!r}'
        assert result["x"] == 1, f'Expected {1!r} but got {result["x"]!r}'
