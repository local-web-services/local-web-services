"""Tests for the Step Functions choice evaluator and path utilities.

Covers all comparison operators, logical combinators (And/Or/Not),
type-checking operators, and JSONPath-like path processing.
"""

from __future__ import annotations

from lws.providers.stepfunctions.path_utils import (
    apply_output_path,
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


class TestApplyOutputPath:
    """OutputPath processing."""

    def test_null_returns_empty(self) -> None:
        assert apply_output_path({"x": 1}, None) == {}, "Expected {0!r} but got {1!r}".format({}, apply_output_path({"x": 1}, None))

    def test_root_returns_data(self) -> None:
        data = {"x": 1}
        assert apply_output_path(data, "$") == data, f'Expected {data!r} but got {apply_output_path(data, "$")!r}'

    def test_nested_path(self) -> None:
        data = {"a": 1, "b": 2}
        assert apply_output_path(data, "$.a") == 1, f'Expected {1!r} but got {apply_output_path(data, "$.a")!r}'
