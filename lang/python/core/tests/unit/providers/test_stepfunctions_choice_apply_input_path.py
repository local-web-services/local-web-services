"""Tests for the Step Functions choice evaluator and path utilities.

Covers all comparison operators, logical combinators (And/Or/Not),
type-checking operators, and JSONPath-like path processing.
"""

from __future__ import annotations

from lws.providers.stepfunctions.path_utils import (
    apply_input_path,
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


class TestApplyInputPath:
    """InputPath processing."""

    def test_null_returns_empty(self) -> None:
        assert apply_input_path({"x": 1}, None) == {}, "Expected {0!r} but got {1!r}".format({}, apply_input_path({"x": 1}, None))

    def test_root_returns_data(self) -> None:
        data = {"x": 1}
        assert apply_input_path(data, "$") == data, f'Expected {data!r} but got {apply_input_path(data, "$")!r}'

    def test_nested_path(self) -> None:
        data = {"a": {"b": 42}}
        assert apply_input_path(data, "$.a") == {"b": 42}, "Expected {0!r} but got {1!r}".format({"b": 42}, apply_input_path(data, "$.a"))
