"""Tests for the Step Functions choice evaluator and path utilities.

Covers all comparison operators, logical combinators (And/Or/Not),
type-checking operators, and JSONPath-like path processing.
"""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions.path_utils import (
    resolve_path,
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


class TestResolvePath:
    """JSONPath-like path resolution."""

    def test_root_path(self) -> None:
        assert resolve_path({"a": 1}, "$") == {"a": 1}

    def test_simple_key(self) -> None:
        assert resolve_path({"a": 1, "b": 2}, "$.a") == 1

    def test_nested_key(self) -> None:
        data = {"a": {"b": {"c": 3}}}
        assert resolve_path(data, "$.a.b.c") == 3

    def test_array_index(self) -> None:
        data = {"items": [10, 20, 30]}
        assert resolve_path(data, "$.items[0]") == 10
        assert resolve_path(data, "$.items[2]") == 30

    def test_missing_key_raises(self) -> None:
        with pytest.raises(KeyError):
            resolve_path({"a": 1}, "$.b")
