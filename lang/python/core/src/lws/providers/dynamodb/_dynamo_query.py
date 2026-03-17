"""DynamoDB key condition and query parsing helpers, plus the _VersionStore class."""

from __future__ import annotations

import re
import time

# ---------------------------------------------------------------------------
# Key condition / filter parsing
# ---------------------------------------------------------------------------


def _resolve_name(token: str, expression_names: dict | None) -> str:
    """Resolve an expression attribute name like ``#attr`` to its real name."""
    if expression_names and token.startswith("#"):
        return expression_names.get(token, token)
    return token


def _resolve_value(token: str, expression_values: dict | None) -> object:
    """Resolve an expression attribute value like ``:val`` to its real value."""
    if expression_values and token.startswith(":"):
        raw = expression_values.get(token)
        if isinstance(raw, dict) and len(raw) == 1:
            type_key = next(iter(raw))
            if type_key in ("S", "N", "B", "BOOL", "NULL"):
                return raw[type_key]
        return raw
    return token


def _parse_key_condition(
    key_condition: str,
    expression_values: dict | None,
    expression_names: dict | None,
) -> tuple[str, list[object]]:
    """Parse a DynamoDB KeyConditionExpression into a SQL WHERE clause + params.

    Supported forms:
    - ``pk = :val``
    - ``pk = :val AND sk = :val2``
    - ``pk = :val AND sk > :val2``  (also <, >=, <=)
    - ``pk = :val AND sk BETWEEN :a AND :b``
    - ``pk = :val AND begins_with(sk, :prefix)``
    """
    expr = key_condition.strip()
    parts = re.split(r"\bAND\b", expr, flags=re.IGNORECASE)

    sql_parts: list[str] = []
    params: list[object] = []

    i = 0
    while i < len(parts):
        part = parts[i].strip()
        consumed, i = _parse_key_part(
            part, parts, i, sql_parts, params, expression_values, expression_names
        )
        if not consumed:
            i += 1

    where = " AND ".join(sql_parts) if sql_parts else "1=1"
    return where, params


def _parse_key_part(
    part: str,
    parts: list[str],
    i: int,
    sql_parts: list[str],
    params: list[object],
    expression_values: dict | None,
    expression_names: dict | None,
) -> tuple[bool, int]:
    """Parse a single key condition part. Returns (consumed, next_index)."""
    if _try_parse_begins_with(part, sql_parts, params, expression_values, expression_names):
        return True, i + 1

    consumed, new_i = _try_parse_between(
        part, parts, i, sql_parts, params, expression_values, expression_names
    )
    if consumed:
        return True, new_i

    if _try_parse_comparison(part, sql_parts, params, expression_values, expression_names):
        return True, i + 1

    return False, i


def _try_parse_begins_with(
    part: str,
    sql_parts: list[str],
    params: list[object],
    expression_values: dict | None,
    expression_names: dict | None,
) -> bool:
    """Try to parse a begins_with condition. Returns True if matched."""
    bw_match = re.match(
        r"begins_with\s*\(\s*([#\w]+)\s*,\s*([:\w]+)\s*\)",
        part,
        re.IGNORECASE,
    )
    if not bw_match:
        return False
    _resolve_name(bw_match.group(1), expression_names)
    val = _resolve_value(bw_match.group(2), expression_values)
    col = "pk" if not sql_parts else "sk"
    sql_parts.append(f"{col} LIKE ? || '%'")
    params.append(val)
    return True


def _try_parse_between(
    part: str,
    parts: list[str],
    i: int,
    sql_parts: list[str],
    params: list[object],
    expression_values: dict | None,
    expression_names: dict | None,
) -> tuple[bool, int]:
    """Try to parse a BETWEEN condition. Returns (matched, next_index)."""
    between_match = re.match(
        r"([#\w]+)\s+BETWEEN\s+([:\w]+)\s*$",
        part,
        re.IGNORECASE,
    )
    if not between_match:
        return False, i
    _resolve_name(between_match.group(1), expression_names)
    val_a = _resolve_value(between_match.group(2), expression_values)
    val_b_raw = parts[i + 1].strip() if i + 1 < len(parts) else ""
    val_b = _resolve_value(val_b_raw, expression_values)
    col = "sk"
    sql_parts.append(f"{col} BETWEEN ? AND ?")
    params.extend([val_a, val_b])
    return True, i + 2


def _try_parse_comparison(
    part: str,
    sql_parts: list[str],
    params: list[object],
    expression_values: dict | None,
    expression_names: dict | None,
) -> bool:
    """Try to parse a comparison condition. Returns True if matched."""
    cmp_match = re.match(
        r"([#\w]+)\s*(=|<>|<=|>=|<|>)\s*([:\w]+)",
        part,
    )
    if not cmp_match:
        return False
    _resolve_name(cmp_match.group(1), expression_names)
    op = cmp_match.group(2)
    val = _resolve_value(cmp_match.group(3), expression_values)
    col = "pk" if not sql_parts else "sk"
    sql_parts.append(f"{col} {op} ?")
    params.append(val)
    return True


# ---------------------------------------------------------------------------
# Eventual consistency helpers
# ---------------------------------------------------------------------------


class _VersionStore:
    """Track item versions for eventual consistency simulation.

    Stores the previous version of each item along with a write timestamp.
    When a read is "eventually consistent" (the default), stale data may
    be returned if the item was written within the consistency delay window.
    """

    def __init__(self, delay_ms: int = 200) -> None:
        self._delay_seconds = delay_ms / 1000.0
        # (table, pk, sk) -> (write_timestamp, previous_item_json | None)
        self._versions: dict[tuple[str, str, str], tuple[float, str | None]] = {}

    def record_write(
        self, table_name: str, pk: str, sk: str, previous_item_json: str | None
    ) -> None:
        """Record a write event for eventual consistency tracking."""
        self._versions[(table_name, pk, sk)] = (time.monotonic(), previous_item_json)

    def get_consistent_item(
        self,
        table_name: str,
        pk: str,
        sk: str,
        current_item_json: str | None,
        consistent_read: bool,
    ) -> str | None:
        """Return the item JSON to use, considering consistency mode."""
        if consistent_read:
            return current_item_json

        key = (table_name, pk, sk)
        version_info = self._versions.get(key)
        if version_info is None:
            return current_item_json

        write_time, previous_json = version_info
        elapsed = time.monotonic() - write_time
        if elapsed < self._delay_seconds:
            return previous_json
        return current_item_json

    def is_stale(self, table_name: str, pk: str, sk: str) -> bool:
        """Check if an item is within the staleness window."""
        key = (table_name, pk, sk)
        version_info = self._versions.get(key)
        if version_info is None:
            return False
        write_time, _ = version_info
        return (time.monotonic() - write_time) < self._delay_seconds
