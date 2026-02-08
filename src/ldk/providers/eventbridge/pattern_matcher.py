"""EventBridge event pattern matching engine.

Implements the EventBridge pattern matching logic as pure functions.
Supports: exact value matching, prefix matching, numeric range,
exists/not-exists, anything-but, and nested detail patterns.
"""

from __future__ import annotations


def match_event(pattern: dict, event: dict) -> bool:
    """Return True if *event* matches the EventBridge *pattern*.

    Each key in the pattern must be present in the event and at least one
    of the pattern conditions for that key must match the event value.

    Parameters
    ----------
    pattern:
        An EventBridge event pattern dict. Keys map to lists of match
        conditions.
    event:
        The event dict to test against the pattern.

    Returns
    -------
    bool
        True if the event matches all conditions in the pattern.
    """
    if not pattern:
        return True

    for key, conditions in pattern.items():
        event_value = event.get(key)
        if not _key_matches(conditions, event_value):
            return False

    return True


def _key_matches(conditions: list | dict, event_value: object) -> bool:
    """Check whether a single pattern key matches the event value.

    If *conditions* is a dict, it represents a nested pattern that must
    be matched recursively against the event value (which should also be
    a dict).  If it is a list, each element is a match condition and at
    least one must match.
    """
    if isinstance(conditions, dict):
        if not isinstance(event_value, dict):
            return False
        return match_event(conditions, event_value)

    if not isinstance(conditions, list):
        return False

    return _any_condition_matches(conditions, event_value)


def _any_condition_matches(conditions: list, event_value: object) -> bool:
    """Return True if at least one condition in the list matches."""
    for condition in conditions:
        if _single_condition_matches(condition, event_value):
            return True
    return False


def _single_condition_matches(condition: object, event_value: object) -> bool:
    """Evaluate a single match condition against an event value."""
    if isinstance(condition, dict):
        return _dict_condition_matches(condition, event_value)

    # Exact value match (string, number, boolean)
    return event_value == condition


def _dict_condition_matches(condition: dict, event_value: object) -> bool:
    """Dispatch structured condition objects."""
    if "exists" in condition:
        return _eval_exists(event_value, condition["exists"])

    if "prefix" in condition:
        return _eval_prefix(event_value, condition["prefix"])

    if "numeric" in condition:
        return _eval_numeric(event_value, condition["numeric"])

    if "anything-but" in condition:
        return _eval_anything_but(event_value, condition["anything-but"])

    return False


# ------------------------------------------------------------------
# Individual evaluators
# ------------------------------------------------------------------


def _eval_exists(event_value: object, should_exist: bool) -> bool:
    """Evaluate an ``{"exists": true/false}`` condition."""
    if should_exist:
        return event_value is not None
    return event_value is None


def _eval_prefix(event_value: object, prefix: str) -> bool:
    """Evaluate a ``{"prefix": "val"}`` condition."""
    if not isinstance(event_value, str):
        return False
    return event_value.startswith(prefix)


def _eval_numeric(event_value: object, operators: list) -> bool:
    """Evaluate a ``{"numeric": [">=", 100, "<", 200]}`` condition.

    The *operators* list contains alternating (operator, operand) pairs.
    All pairs must match.
    """
    try:
        num_value = float(event_value)  # type: ignore[arg-type]
    except (TypeError, ValueError):
        return False

    i = 0
    while i < len(operators) - 1:
        op = operators[i]
        operand = float(operators[i + 1])
        if not _compare_numeric(num_value, op, operand):
            return False
        i += 2

    return True


def _compare_numeric(value: float, op: str, operand: float) -> bool:
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


def _eval_anything_but(event_value: object, exclusions: object) -> bool:
    """Evaluate an ``{"anything-but": ["red"]}`` or ``{"anything-but": "red"}`` condition.

    Returns True when *event_value* does NOT match any of the exclusions.
    """
    if event_value is None:
        return False

    if isinstance(exclusions, list):
        return all(event_value != exc for exc in exclusions)

    # Single value exclusion
    return event_value != exclusions
