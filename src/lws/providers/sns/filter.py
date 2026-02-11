"""SNS message filter policy evaluation.

Implements the subset of SNS subscription filter policies used by
local development: exact string matching, numeric comparisons,
exists checks, and anything-but exclusion.
"""

from __future__ import annotations

from lws.providers._shared.numeric import eval_numeric_range


def matches_filter_policy(
    message_attributes: dict,
    filter_policy: dict | None,
) -> bool:
    """Return True if *message_attributes* satisfy *filter_policy*.

    When *filter_policy* is ``None`` or empty every message matches.
    Each key in the policy must be present in *message_attributes* and
    at least one of the policy conditions for that key must match.

    Supported condition types:
    - Exact string: ``{"color": ["red", "blue"]}``
    - Numeric:      ``{"price": [{"numeric": [">=", 100]}]}``
    - Exists:       ``{"color": [{"exists": true}]}``
    - Anything-but: ``{"color": [{"anything-but": ["red"]}]}``
    """
    if not filter_policy:
        return True

    for key, conditions in filter_policy.items():
        attr = message_attributes.get(key)
        if not _any_condition_matches(attr, conditions):
            return False

    return True


def _any_condition_matches(attr: dict | None, conditions: list) -> bool:
    """Return True if at least one condition in the list matches *attr*."""
    for condition in conditions:
        if _single_condition_matches(attr, condition):
            return True
    return False


def _single_condition_matches(attr: dict | None, condition: object) -> bool:
    """Evaluate a single filter condition against an attribute value."""
    if isinstance(condition, dict):
        return _dict_condition_matches(attr, condition)

    # Exact string match -- condition is a plain string
    if attr is None:
        return False
    attr_value = _extract_value(attr)
    return str(attr_value) == str(condition)


def _dict_condition_matches(attr: dict | None, condition: dict) -> bool:
    """Dispatch structured condition objects (exists, numeric, anything-but)."""
    if "exists" in condition:
        return _eval_exists(attr, condition["exists"])

    if "numeric" in condition:
        if attr is None:
            return False
        return _eval_numeric(_extract_value(attr), condition["numeric"])

    if "anything-but" in condition:
        if attr is None:
            return False
        return _eval_anything_but(_extract_value(attr), condition["anything-but"])

    return False


# ------------------------------------------------------------------
# Individual evaluators
# ------------------------------------------------------------------


def _eval_exists(attr: dict | None, should_exist: bool) -> bool:
    """Evaluate an ``{"exists": true/false}`` condition."""
    if should_exist:
        return attr is not None
    return attr is None


def _eval_numeric(value: object, operators: list) -> bool:
    """Evaluate a ``{"numeric": [">=", 100, "<", 200]}`` condition."""
    return eval_numeric_range(value, operators)


def _eval_anything_but(value: object, exclusions: list) -> bool:
    """Evaluate an ``{"anything-but": ["red"]}`` condition.

    Returns True when *value* does NOT match any of the *exclusions*.
    """
    str_value = str(value)
    return all(str_value != str(exc) for exc in exclusions)


# ------------------------------------------------------------------
# Attribute value extraction
# ------------------------------------------------------------------


def _extract_value(attr: object) -> object:
    """Extract the value from an SNS message attribute dict.

    SNS message attributes follow the shape
    ``{"DataType": "String", "StringValue": "red"}``.
    If *attr* is already a plain value, return it directly.
    """
    if isinstance(attr, dict):
        for key in ("StringValue", "BinaryValue"):
            if key in attr:
                return attr[key]
        # Fall back to the first value
        if attr:
            return next(iter(attr.values()))
    return attr
