"""Match operators for body-level request matching.

Supports ``$eq``, ``$ne``, ``$gt``, ``$gte``, ``$lt``, ``$lte``,
``$regex``, ``$exists``, and ``$in``.
"""

from __future__ import annotations

import re
from typing import Any


def _coerce_numeric(value: Any) -> float | None:
    """Try to coerce a value to a float for numeric comparison."""
    try:
        return float(value)
    except (TypeError, ValueError):
        return None


def evaluate_operator(operator: str, actual: Any, expected: Any) -> bool:
    """Evaluate a single match operator against an actual value."""
    if operator == "$eq":
        return actual == expected
    if operator == "$ne":
        return actual != expected
    if operator in ("$gt", "$gte", "$lt", "$lte"):
        return _evaluate_numeric(operator, actual, expected)
    if operator == "$regex":
        return bool(re.search(str(expected), str(actual))) if actual is not None else False
    if operator == "$exists":
        return (actual is not None) == bool(expected)
    if operator == "$in":
        if not isinstance(expected, list):
            return False
        return actual in expected
    return False


def _evaluate_numeric(operator: str, actual: Any, expected: Any) -> bool:
    """Evaluate numeric comparison operators."""
    a = _coerce_numeric(actual)
    b = _coerce_numeric(expected)
    if a is None or b is None:
        return False
    if operator == "$gt":
        return a > b
    if operator == "$gte":
        return a >= b
    if operator == "$lt":
        return a < b
    if operator == "$lte":
        return a <= b
    return False  # pragma: no cover


def match_value(actual: Any, matcher: Any) -> bool:
    """Match an actual value against a matcher (operator dict or exact value).

    If *matcher* is a dict with operator keys (``$eq``, ``$regex``, etc.),
    evaluate each operator.  Otherwise, treat as exact equality.
    """
    if isinstance(matcher, dict):
        operators = {k: v for k, v in matcher.items() if k.startswith("$")}
        if operators:
            return all(evaluate_operator(op, actual, val) for op, val in operators.items())
    return actual == matcher
