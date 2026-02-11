"""Shared numeric comparison helpers for filter/pattern matching."""

from __future__ import annotations


def eval_numeric_range(value: object, operators: list) -> bool:
    """Evaluate a ``{"numeric": [">=", 100, "<", 200]}`` condition.

    The *operators* list contains alternating (operator, operand) pairs.
    All pairs must match.
    """
    try:
        num_value = float(value)  # type: ignore[arg-type]
    except (TypeError, ValueError):
        return False

    i = 0
    while i < len(operators) - 1:
        op = operators[i]
        operand = float(operators[i + 1])
        if not compare_numeric(num_value, op, operand):
            return False
        i += 2

    return True


def compare_numeric(value: float, op: str, operand: float) -> bool:
    """Perform a single numeric comparison."""
    if op == "=":
        return value == operand
    if op == ">":
        return value > operand
    if op == ">=":
        return value >= operand
    if op == "<":
        return value < operand
    if op == "<=":
        return value <= operand
    return False
