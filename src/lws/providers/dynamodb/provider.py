"""SQLite-backed DynamoDB provider for local development."""

from __future__ import annotations

import json
import re
import time
from pathlib import Path
from typing import Any

import aiosqlite

from lws.interfaces import (
    GsiDefinition,
    IKeyValueStore,
    KeyAttribute,
    TableConfig,
)
from lws.providers.dynamodb.expressions import apply_filter_expression
from lws.providers.dynamodb.streams import EventName, StreamDispatcher
from lws.providers.dynamodb.update_expression import apply_update_expression

# Maximum number of items in a single batch operation (DynamoDB limit)
_MAX_BATCH_SIZE = 25

# ---------------------------------------------------------------------------
# Helpers: DynamoDB JSON conversion
# ---------------------------------------------------------------------------


def _extract_key_value(item: dict, key_attr: KeyAttribute) -> str:
    """Extract and stringify a key value from a DynamoDB-format or plain item.

    Handles both DynamoDB wire format ``{"pk": {"S": "val"}}`` and plain
    ``{"pk": "val"}``.
    """
    raw = item.get(key_attr.name)
    if raw is None:
        return ""
    # DynamoDB-typed value like {"S": "abc"}
    if isinstance(raw, dict) and len(raw) == 1:
        type_key = next(iter(raw))
        if type_key in ("S", "N", "B"):
            return str(raw[type_key])
    return str(raw)


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


def _from_dynamo_json(item: dict) -> dict:
    """Convert DynamoDB JSON to a plain dict."""
    if not _is_dynamo_json(item):
        return dict(item)
    result: dict = {}
    for key, typed_val in item.items():
        result[key] = _from_dynamo_json_value(typed_val)
    return result


def _parse_number(n: str | int | float) -> int | float:
    """Parse a DynamoDB number string to int or float."""
    return int(n) if "." not in str(n) else float(n)


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


# ---------------------------------------------------------------------------
# GSI Projection helpers (P1-22)
# ---------------------------------------------------------------------------


def _extract_key_names(config: TableConfig) -> list[str]:
    """Get all key attribute names for the main table."""
    names = [config.key_schema.partition_key.name]
    if config.key_schema.sort_key:
        names.append(config.key_schema.sort_key.name)
    return names


def _project_item_for_gsi(item: dict, gsi: GsiDefinition, table_config: TableConfig) -> str:
    """Project an item according to the GSI projection type.

    Returns the item_json string to store in the GSI table.
    """
    projection = gsi.projection_type.upper()
    if projection == "ALL":
        return json.dumps(item)

    # Always include table keys and GSI keys
    key_attrs = set(_extract_key_names(table_config))
    key_attrs.add(gsi.key_schema.partition_key.name)
    if gsi.key_schema.sort_key:
        key_attrs.add(gsi.key_schema.sort_key.name)

    if projection == "KEYS_ONLY":
        projected = {k: v for k, v in item.items() if k in key_attrs}
        return json.dumps(projected)

    if projection == "INCLUDE":
        # Include specified non-key attributes plus all keys
        # The included attributes are stored as a comma-separated string in the
        # projection_type field as "INCLUDE:attr1,attr2" or we infer from the
        # GsiDefinition. For simplicity, we store the full item but filter on read.
        return json.dumps(item)

    # Default to ALL for unknown projection types
    return json.dumps(item)


# ---------------------------------------------------------------------------
# Key condition / filter parsing (kept for SQL-level key conditions)
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
# Eventual consistency helpers (P1-27)
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


# ---------------------------------------------------------------------------
# SqliteDynamoProvider
# ---------------------------------------------------------------------------


class SqliteDynamoProvider(IKeyValueStore):
    """SQLite-backed local DynamoDB provider.

    Each table is stored in its own SQLite database file under
    ``<data_dir>/dynamodb/<table_name>.db``.

    Parameters
    ----------
    data_dir : Path
        Directory for storing SQLite database files.
    tables : list[TableConfig]
        Table configurations to initialize.
    consistency_delay_ms : int
        Delay in milliseconds for eventual consistency simulation.
        Default is 200ms. Set to 0 to disable.
    stream_dispatcher : StreamDispatcher | None
        Optional stream dispatcher for DynamoDB Streams emulation.
    """

    def __init__(
        self,
        data_dir: Path,
        tables: list[TableConfig] | None = None,
        consistency_delay_ms: int = 200,
        stream_dispatcher: StreamDispatcher | None = None,
    ) -> None:
        self._data_dir = data_dir
        self._tables = {t.table_name: t for t in (tables or [])}
        self._connections: dict[str, aiosqlite.Connection] = {}
        self._version_store = _VersionStore(delay_ms=consistency_delay_ms)
        self._stream_dispatcher = stream_dispatcher

    def _resolve_table_name(self, table_name: str) -> str:
        """Normalize a table name that may be an ARN or contain a logical ID."""
        if table_name in self._tables:
            return table_name
        # Handle ARN format: arn:...:table/TableName or arn:...:table/LogicalId
        if "/" in table_name:
            suffix = table_name.rsplit("/", 1)[-1]
            if suffix in self._tables:
                return suffix
        # Try matching as a substring (logical ID in ARN)
        for known_name in self._tables:
            if known_name in table_name:
                return known_name
        return table_name

    # -- Provider lifecycle ---------------------------------------------------

    @property
    def name(self) -> str:
        return "dynamodb"

    async def start(self) -> None:
        db_dir = self._data_dir / "dynamodb"
        db_dir.mkdir(parents=True, exist_ok=True)

        for table_name, config in self._tables.items():
            db_path = db_dir / f"{table_name}.db"
            conn = await aiosqlite.connect(str(db_path))
            self._connections[table_name] = conn

            # Enable WAL mode for better concurrent access (P1-28)
            await conn.execute("PRAGMA journal_mode=WAL")

            # Main items table
            await conn.execute(
                "CREATE TABLE IF NOT EXISTS items "
                "(pk TEXT, sk TEXT, item_json TEXT, PRIMARY KEY (pk, sk))"
            )

            # GSI tables
            for gsi in config.gsi_definitions:
                await conn.execute(
                    f"CREATE TABLE IF NOT EXISTS gsi_{gsi.index_name} "
                    "(pk TEXT, sk TEXT, item_json TEXT, PRIMARY KEY (pk, sk))"
                )

            await conn.commit()

        if self._stream_dispatcher is not None:
            await self._stream_dispatcher.start()

    async def stop(self) -> None:
        if self._stream_dispatcher is not None:
            await self._stream_dispatcher.stop()
        for conn in self._connections.values():
            await conn.close()
        self._connections.clear()

    async def health_check(self) -> bool:
        if not self._connections:
            return False
        for conn in self._connections.values():
            if conn._running is False:  # pylint: disable=protected-access
                return False
        return True

    # -- CRUD -----------------------------------------------------------------

    async def put_item(self, table_name: str, item: dict) -> None:
        table_name = self._resolve_table_name(table_name)
        config = self._tables[table_name]
        conn = self._connections[table_name]

        pk = _extract_key_value(item, config.key_schema.partition_key)
        sk = _extract_sk(item, config)

        # Fetch old item for streams and consistency tracking
        old_item_json = await self._fetch_item_json(conn, pk, sk)

        item_json = json.dumps(item)

        await conn.execute(
            "INSERT OR REPLACE INTO items (pk, sk, item_json) VALUES (?, ?, ?)",
            (pk, sk, item_json),
        )

        # Maintain GSI tables with projection support (P1-22)
        for gsi in config.gsi_definitions:
            await self._update_gsi_entry(conn, gsi, item, config)

        await conn.commit()

        # Eventual consistency tracking (P1-27)
        self._version_store.record_write(table_name, pk, sk, old_item_json)

        # Stream events (P1-26)
        await self._emit_stream_event(table_name, item, old_item_json, config)

    async def get_item(
        self,
        table_name: str,
        key: dict,
        consistent_read: bool = True,
    ) -> dict | None:
        table_name = self._resolve_table_name(table_name)
        config = self._tables[table_name]
        conn = self._connections[table_name]

        pk = _extract_key_value(key, config.key_schema.partition_key)
        sk = _extract_sk(key, config)

        current_json = await self._fetch_item_json(conn, pk, sk)

        # Apply eventual consistency (P1-27)
        result_json = self._version_store.get_consistent_item(
            table_name, pk, sk, current_json, consistent_read
        )

        if result_json is None:
            return None
        return json.loads(result_json)

    async def delete_item(self, table_name: str, key: dict) -> None:
        table_name = self._resolve_table_name(table_name)
        config = self._tables[table_name]
        conn = self._connections[table_name]

        pk = _extract_key_value(key, config.key_schema.partition_key)
        sk = _extract_sk(key, config)

        # Fetch old item for cleanup and streams
        old_item_json = await self._fetch_item_json(conn, pk, sk)

        await conn.execute(
            "DELETE FROM items WHERE pk = ? AND sk = ?",
            (pk, sk),
        )

        # Clean up GSI entries
        if old_item_json is not None:
            item = json.loads(old_item_json)
            for gsi in config.gsi_definitions:
                await self._delete_gsi_entry(conn, gsi, item)

        await conn.commit()

        # Eventual consistency tracking (P1-27)
        self._version_store.record_write(table_name, pk, sk, old_item_json)

        # Stream events (P1-26)
        if old_item_json is not None:
            await self._emit_delete_stream_event(table_name, json.loads(old_item_json), config)

    async def update_item(
        self,
        table_name: str,
        key: dict,
        update_expression: str,
        expression_values: dict | None = None,
        expression_names: dict | None = None,
    ) -> dict:
        existing = await self.get_item(table_name, key)
        if existing is None:
            existing = dict(key)

        # Use the enhanced update expression evaluator (P1-24)
        apply_update_expression(existing, update_expression, expression_names, expression_values)

        await self.put_item(table_name, existing)
        return existing

    # -- Query / Scan ---------------------------------------------------------

    async def query(
        self,
        table_name: str,
        key_condition: str,
        expression_values: dict | None = None,
        expression_names: dict | None = None,
        index_name: str | None = None,
        filter_expression: str | None = None,
    ) -> list[dict]:
        table_name = self._resolve_table_name(table_name)
        conn = self._connections[table_name]
        table = f"gsi_{index_name}" if index_name else "items"

        where, params = _parse_key_condition(key_condition, expression_values, expression_names)

        cursor = await conn.execute(
            f"SELECT item_json FROM {table} WHERE {where}",
            params,
        )
        rows = await cursor.fetchall()
        items = [json.loads(row[0]) for row in rows]

        # Apply GSI projection filtering (P1-22)
        if index_name:
            items = self._apply_gsi_projection(table_name, index_name, items)

        # Apply post-fetch filter using enhanced expression evaluator (P1-23)
        items = apply_filter_expression(
            items, filter_expression, expression_names, expression_values
        )
        return items

    async def scan(
        self,
        table_name: str,
        filter_expression: str | None = None,
        expression_values: dict | None = None,
        expression_names: dict | None = None,
    ) -> list[dict]:
        table_name = self._resolve_table_name(table_name)
        conn = self._connections[table_name]
        cursor = await conn.execute("SELECT item_json FROM items")
        rows = await cursor.fetchall()
        items = [json.loads(row[0]) for row in rows]

        # Apply post-fetch filter using enhanced expression evaluator (P1-23)
        items = apply_filter_expression(
            items, filter_expression, expression_names, expression_values
        )
        return items

    # -- Batch ----------------------------------------------------------------

    async def batch_get_items(self, table_name: str, keys: list[dict]) -> list[dict]:
        _validate_batch_size(keys, "batch_get_items")
        results: list[dict] = []
        for key in keys:
            item = await self.get_item(table_name, key)
            if item is not None:
                results.append(item)
        return results

    async def batch_write_items(
        self,
        table_name: str,
        put_items: list[dict] | None = None,
        delete_keys: list[dict] | None = None,
    ) -> None:
        total = len(put_items or []) + len(delete_keys or [])
        _validate_batch_size_count(total, "batch_write_items")
        for item in put_items or []:
            await self.put_item(table_name, item)
        for key in delete_keys or []:
            await self.delete_item(table_name, key)

    # -- Table management ------------------------------------------------------

    async def create_table(self, config: TableConfig) -> dict:
        if config.table_name in self._tables:
            return self._build_table_description(self._tables[config.table_name])

        self._tables[config.table_name] = config

        db_dir = self._data_dir / "dynamodb"
        db_dir.mkdir(parents=True, exist_ok=True)
        db_path = db_dir / f"{config.table_name}.db"
        conn = await aiosqlite.connect(str(db_path))
        self._connections[config.table_name] = conn

        await conn.execute("PRAGMA journal_mode=WAL")
        await conn.execute(
            "CREATE TABLE IF NOT EXISTS items "
            "(pk TEXT, sk TEXT, item_json TEXT, PRIMARY KEY (pk, sk))"
        )
        for gsi in config.gsi_definitions:
            await conn.execute(
                f"CREATE TABLE IF NOT EXISTS gsi_{gsi.index_name} "
                "(pk TEXT, sk TEXT, item_json TEXT, PRIMARY KEY (pk, sk))"
            )
        await conn.commit()

        return self._build_table_description(config)

    async def delete_table(self, table_name: str) -> dict:
        if table_name not in self._tables:
            raise KeyError(f"Table not found: {table_name}")

        config = self._tables[table_name]
        description = self._build_table_description(config)

        conn = self._connections.pop(table_name)
        await conn.close()
        del self._tables[table_name]

        db_path = self._data_dir / "dynamodb" / f"{table_name}.db"
        if db_path.exists():
            db_path.unlink()

        return description

    async def describe_table(self, table_name: str) -> dict:
        if table_name not in self._tables:
            raise KeyError(f"Table not found: {table_name}")
        return self._build_table_description(self._tables[table_name])

    async def list_tables(self) -> list[str]:
        return sorted(self._tables.keys())

    def _build_table_description(self, config: TableConfig) -> dict:
        """Build an AWS-compatible TableDescription dict."""
        key_schema = [
            {
                "AttributeName": config.key_schema.partition_key.name,
                "KeyType": "HASH",
            }
        ]
        attr_defs = [
            {
                "AttributeName": config.key_schema.partition_key.name,
                "AttributeType": config.key_schema.partition_key.type,
            }
        ]
        if config.key_schema.sort_key:
            key_schema.append(
                {
                    "AttributeName": config.key_schema.sort_key.name,
                    "KeyType": "RANGE",
                }
            )
            attr_defs.append(
                {
                    "AttributeName": config.key_schema.sort_key.name,
                    "AttributeType": config.key_schema.sort_key.type,
                }
            )

        description: dict = {
            "TableName": config.table_name,
            "TableStatus": "ACTIVE",
            "KeySchema": key_schema,
            "AttributeDefinitions": attr_defs,
            "TableArn": f"arn:aws:dynamodb:us-east-1:000000000000:table/{config.table_name}",
            "ItemCount": 0,
            "TableSizeBytes": 0,
            "CreationDateTime": time.time(),
            "ProvisionedThroughput": {
                "ReadCapacityUnits": 0,
                "WriteCapacityUnits": 0,
            },
        }

        if config.gsi_definitions:
            gsis = []
            for gsi in config.gsi_definitions:
                gsi_key_schema = [
                    {
                        "AttributeName": gsi.key_schema.partition_key.name,
                        "KeyType": "HASH",
                    }
                ]
                gsi_attr = {
                    "AttributeName": gsi.key_schema.partition_key.name,
                    "AttributeType": gsi.key_schema.partition_key.type,
                }
                if gsi_attr not in attr_defs:
                    attr_defs.append(gsi_attr)
                if gsi.key_schema.sort_key:
                    gsi_key_schema.append(
                        {
                            "AttributeName": gsi.key_schema.sort_key.name,
                            "KeyType": "RANGE",
                        }
                    )
                    gsi_sk_attr = {
                        "AttributeName": gsi.key_schema.sort_key.name,
                        "AttributeType": gsi.key_schema.sort_key.type,
                    }
                    if gsi_sk_attr not in attr_defs:
                        attr_defs.append(gsi_sk_attr)
                gsis.append(
                    {
                        "IndexName": gsi.index_name,
                        "KeySchema": gsi_key_schema,
                        "Projection": {"ProjectionType": gsi.projection_type},
                        "IndexStatus": "ACTIVE",
                        "ProvisionedThroughput": {
                            "ReadCapacityUnits": 0,
                            "WriteCapacityUnits": 0,
                        },
                    }
                )
            description["GlobalSecondaryIndexes"] = gsis

        return description

    # -- Private helpers -------------------------------------------------------

    async def _fetch_item_json(self, conn: aiosqlite.Connection, pk: str, sk: str) -> str | None:
        """Fetch raw item JSON from the items table."""
        cursor = await conn.execute(
            "SELECT item_json FROM items WHERE pk = ? AND sk = ?",
            (pk, sk),
        )
        row = await cursor.fetchone()
        return row[0] if row else None

    async def _update_gsi_entry(
        self,
        conn: aiosqlite.Connection,
        gsi: GsiDefinition,
        item: dict,
        table_config: TableConfig,
    ) -> None:
        """Insert or replace an item in a GSI table with projection support."""
        gsi_pk = _extract_key_value(item, gsi.key_schema.partition_key)
        if not gsi_pk:
            return  # Item doesn't project into this GSI
        gsi_sk = (
            _extract_key_value(item, gsi.key_schema.sort_key) if gsi.key_schema.sort_key else ""
        )
        projected_json = _project_item_for_gsi(item, gsi, table_config)
        await conn.execute(
            f"INSERT OR REPLACE INTO gsi_{gsi.index_name} (pk, sk, item_json) VALUES (?, ?, ?)",
            (gsi_pk, gsi_sk, projected_json),
        )

    async def _delete_gsi_entry(
        self,
        conn: aiosqlite.Connection,
        gsi: GsiDefinition,
        item: dict,
    ) -> None:
        """Delete an item from a GSI table."""
        gsi_pk = _extract_key_value(item, gsi.key_schema.partition_key)
        gsi_sk = (
            _extract_key_value(item, gsi.key_schema.sort_key) if gsi.key_schema.sort_key else ""
        )
        await conn.execute(
            f"DELETE FROM gsi_{gsi.index_name} WHERE pk = ? AND sk = ?",
            (gsi_pk, gsi_sk),
        )

    def _apply_gsi_projection(
        self, table_name: str, index_name: str, items: list[dict]
    ) -> list[dict]:
        """Apply GSI projection filtering to query results."""
        config = self._tables[table_name]
        gsi = _find_gsi(config, index_name)
        if gsi is None or gsi.projection_type.upper() == "ALL":
            return items

        key_attrs = set(_extract_key_names(config))
        key_attrs.add(gsi.key_schema.partition_key.name)
        if gsi.key_schema.sort_key:
            key_attrs.add(gsi.key_schema.sort_key.name)

        if gsi.projection_type.upper() == "KEYS_ONLY":
            return [{k: v for k, v in item.items() if k in key_attrs} for item in items]

        return items

    async def _emit_stream_event(
        self,
        table_name: str,
        new_item: dict,
        old_item_json: str | None,
        config: TableConfig,
    ) -> None:
        """Emit a stream event for put/update operations."""
        if self._stream_dispatcher is None:
            return
        keys = _build_keys_dict(new_item, config)
        old_item = json.loads(old_item_json) if old_item_json else None
        event_name = EventName.MODIFY if old_item else EventName.INSERT
        await self._stream_dispatcher.emit(
            event_name=event_name,
            table_name=table_name,
            keys=keys,
            new_image=new_item,
            old_image=old_item,
        )

    async def _emit_delete_stream_event(
        self,
        table_name: str,
        old_item: dict,
        config: TableConfig,
    ) -> None:
        """Emit a REMOVE stream event."""
        if self._stream_dispatcher is None:
            return
        keys = _build_keys_dict(old_item, config)
        await self._stream_dispatcher.emit(
            event_name=EventName.REMOVE,
            table_name=table_name,
            keys=keys,
            new_image=None,
            old_image=old_item,
        )


# ---------------------------------------------------------------------------
# Module-level helpers
# ---------------------------------------------------------------------------


def _extract_sk(item: dict, config: TableConfig) -> str:
    """Extract the sort key value from an item, or empty string if no SK."""
    if config.key_schema.sort_key:
        return _extract_key_value(item, config.key_schema.sort_key)
    return ""


def _find_gsi(config: TableConfig, index_name: str) -> GsiDefinition | None:
    """Find a GSI definition by name."""
    for gsi in config.gsi_definitions:
        if gsi.index_name == index_name:
            return gsi
    return None


def _build_keys_dict(item: dict, config: TableConfig) -> dict[str, Any]:
    """Build a keys-only dict from an item for stream events."""
    keys: dict[str, Any] = {}
    pk_name = config.key_schema.partition_key.name
    if pk_name in item:
        keys[pk_name] = item[pk_name]
    if config.key_schema.sort_key:
        sk_name = config.key_schema.sort_key.name
        if sk_name in item:
            keys[sk_name] = item[sk_name]
    return keys


def _validate_batch_size(items: list, operation: str) -> None:
    """Validate that a batch doesn't exceed the DynamoDB 25-item limit."""
    if len(items) > _MAX_BATCH_SIZE:
        raise ValueError(
            f"{operation}: batch size {len(items)} exceeds maximum of {_MAX_BATCH_SIZE}"
        )


def _validate_batch_size_count(count: int, operation: str) -> None:
    """Validate that a batch total doesn't exceed the DynamoDB 25-item limit."""
    if count > _MAX_BATCH_SIZE:
        raise ValueError(f"{operation}: batch size {count} exceeds maximum of {_MAX_BATCH_SIZE}")
