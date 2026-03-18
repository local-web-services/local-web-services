"""DynamoDB JSON conversion helpers."""

from __future__ import annotations


def _is_dynamo_json(item: dict) -> bool:
    """Return True if *item* looks like DynamoDB JSON (all values are typed maps)."""
    if not item:
        return False
    for val in item.values():
        if not isinstance(val, dict):
            return False
        keys = set(val.keys())
        # Accept common DynamoDB type descriptors
        if not keys.intersection({"S", "N", "B", "BOOL", "NULL", "L", "M", "SS", "NS", "BS"}):
            return False
    return True


def _to_dynamo_json(item: dict) -> dict:
    """Convert a plain dict to DynamoDB JSON format (if not already)."""
    if _is_dynamo_json(item):
        return item
    return {key: _to_dynamo_json_value(val) for key, val in item.items()}


def _to_dynamo_json_value(val: object) -> dict:
    """Convert a single Python value to a DynamoDB JSON typed descriptor."""
    if isinstance(val, bool):
        return {"BOOL": val}
    if isinstance(val, (int, float)):
        return {"N": str(val)}
    if isinstance(val, str):
        return {"S": val}
    if val is None:
        return {"NULL": True}
    if isinstance(val, list):
        return {"L": [_to_dynamo_json_value(v) for v in val]}
    if isinstance(val, dict):
        return {"M": _to_dynamo_json(val)}
    return {"S": str(val)}


_DYNAMO_TYPE_KEYS = {"S", "N", "B", "BOOL", "NULL", "L", "M", "SS", "NS", "BS"}


def _ensure_dynamo_json_value(val: object) -> dict:
    """Ensure a single value is in DynamoDB JSON format.

    If *val* is already a DynamoDB type descriptor dict, return as-is.
    Otherwise wrap it via ``_to_dynamo_json_value``.
    """
    if isinstance(val, dict) and val and set(val.keys()).intersection(_DYNAMO_TYPE_KEYS):
        return val
    return _to_dynamo_json_value(val)


def _ensure_dynamo_json(item: dict) -> dict:
    """Ensure every top-level value in *item* is DynamoDB-typed.

    Handles mixed items where some values are already typed descriptors
    and others are plain Python values (e.g. after update-expression
    evaluation unwraps ``:value`` refs).
    """
    return {key: _ensure_dynamo_json_value(val) for key, val in item.items()}


def _parse_number(n: str | int | float) -> int | float:
    """Parse a DynamoDB number string to int or float."""
    return int(n) if "." not in str(n) else float(n)


# _from_dynamo_json is declared before _DYNAMO_TYPE_CONVERTERS so it can be
# referenced in the dict literal.  _from_dynamo_json itself calls
# _from_dynamo_json_value which is defined below — that's fine because the
# call happens at runtime, not at import time.
def _from_dynamo_json(item: dict) -> dict:
    """Convert DynamoDB JSON to a plain dict."""
    if not _is_dynamo_json(item):
        return dict(item)
    result: dict = {}
    for key, typed_val in item.items():
        result[key] = _from_dynamo_json_value(typed_val)
    return result


def _convert_list(val: list) -> list:
    return [_from_dynamo_json_value(v) for v in val]


def _convert_number_set(val: list) -> set:
    return {_parse_number(n) for n in val}


_DYNAMO_TYPE_CONVERTERS: dict[str, object] = {
    "S": lambda v: v,
    "B": lambda v: v,
    "BOOL": lambda v: v,
    "N": _parse_number,
    "NULL": lambda v: None,
    "L": _convert_list,
    "M": _from_dynamo_json,
    "SS": set,
    "NS": _convert_number_set,
}


def _from_dynamo_json_value(typed_val: dict) -> object:
    """Convert a single DynamoDB typed value to a Python value."""
    for type_key, converter in _DYNAMO_TYPE_CONVERTERS.items():
        if type_key in typed_val:
            return converter(typed_val[type_key])
    return typed_val
