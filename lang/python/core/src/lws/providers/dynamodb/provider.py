"""SQLite-backed DynamoDB provider for local development."""

from __future__ import annotations

import json
from pathlib import Path

import aiosqlite

from lws.interfaces import (
    GsiDefinition,
    IKeyValueStore,
    TableConfig,
)
from lws.providers.dynamodb._dynamo_json import (
    _ensure_dynamo_json,
    _ensure_dynamo_json_value,
    _from_dynamo_json,
    _from_dynamo_json_value,
    _is_dynamo_json,
    _parse_number,
    _to_dynamo_json,
    _to_dynamo_json_value,
)
from lws.providers.dynamodb._dynamo_query import (
    _parse_key_condition,
    _VersionStore,
)
from lws.providers.dynamodb._provider_helpers import (
    _extract_key_value,
    _extract_sk,
    _setup_table_connection,
    _validate_batch_size,
    _validate_batch_size_count,
    apply_gsi_projection,
    build_table_description,
    delete_gsi_entry,
    emit_delete_stream_event,
    emit_stream_event,
    fetch_item_json,
    update_gsi_entry,
)
from lws.providers.dynamodb.expressions import apply_filter_expression
from lws.providers.dynamodb.streams import StreamConfiguration, StreamDispatcher, StreamViewType
from lws.providers.dynamodb.update_expression import apply_update_expression

# Re-export JSON helpers so existing code importing them from this module continues to work
__all__ = [
    "SqliteDynamoProvider",
    "_ensure_dynamo_json",
    "_ensure_dynamo_json_value",
    "_from_dynamo_json",
    "_from_dynamo_json_value",
    "_is_dynamo_json",
    "_parse_number",
    "_to_dynamo_json",
    "_to_dynamo_json_value",
    "_VersionStore",
]


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
        self._initial_table_names: frozenset[str] = frozenset(self._tables.keys())
        self._connections: dict[str, aiosqlite.Connection] = {}
        # Names of tables whose connections are kept open after reset() but
        # whose logical table has been deleted.  create_table() will reuse
        # these connections (fast path) and remove entries from this set.
        self._recycled_connections: set[str] = set()
        self._version_store = _VersionStore(delay_ms=consistency_delay_ms)
        self._consistency_delay_ms = consistency_delay_ms
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
            for table_name, config in self._tables.items():
                if config.stream_enabled:
                    self._configure_stream_for_table(table_name, config)
            await self._stream_dispatcher.start()

    def _configure_stream_for_table(self, table_name: str, config: TableConfig) -> None:
        """Register *table_name* with the stream dispatcher using *config*."""
        if self._stream_dispatcher is None:
            return
        try:
            view_type = StreamViewType(config.stream_view_type)
        except ValueError:
            view_type = StreamViewType.NEW_AND_OLD_IMAGES
        key_attributes = [config.key_schema.partition_key.name]
        if config.key_schema.sort_key:
            key_attributes.append(config.key_schema.sort_key.name)
        self._stream_dispatcher.configure_stream(
            StreamConfiguration(
                table_name=table_name,
                view_type=view_type,
                key_attributes=key_attributes,
            )
        )

    async def stop(self) -> None:
        if self._stream_dispatcher is not None:
            await self._stream_dispatcher.stop()
        for conn in self._connections.values():
            await conn.close()
        self._connections.clear()

    async def reset(self) -> None:
        """Clear all tables' data without closing connections (fast path).

        Dynamic tables are removed from _tables so create_table can re-register
        them, but the underlying SQLite connection is kept alive in _connections
        (recorded in _recycled_connections) to avoid the expensive thread
        start/stop that aiosqlite incurs on every connect()/close() call.
        """
        dynamic_tables = [
            t for t in list(self._tables.keys()) if t not in self._initial_table_names
        ]
        for table_name in dynamic_tables:
            del self._tables[table_name]
            self._recycled_connections.add(table_name)
        for table_name, conn in self._connections.items():
            await conn.execute("DELETE FROM items")
            cursor = await conn.execute(
                "SELECT name FROM sqlite_master WHERE type='table' AND name LIKE 'gsi_%'"
            )
            gsi_tables = [row[0] async for row in cursor]
            for gsi_table in gsi_tables:
                await conn.execute(f"DELETE FROM {gsi_table}")
            await conn.commit()
        self._version_store = _VersionStore(delay_ms=self._consistency_delay_ms)

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
        if self._stream_dispatcher is not None:
            await emit_stream_event(
                self._stream_dispatcher, table_name, item, old_item_json, config
            )

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
        if old_item_json is not None and self._stream_dispatcher is not None:
            await emit_delete_stream_event(
                self._stream_dispatcher, table_name, json.loads(old_item_json), config
            )

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

        # Remember whether the item was stored in DynamoDB JSON format so
        # we can restore it after the evaluator runs.
        needs_rewrap = _is_dynamo_json(existing)

        # Use the enhanced update expression evaluator (P1-24)
        apply_update_expression(existing, update_expression, expression_names, expression_values)

        if needs_rewrap:
            # The evaluator unwraps DynamoDB-typed expression values to
            # plain Python values, producing a mixed-format item.  Re-wrap
            # so the stored item and any returned Attributes stay in
            # DynamoDB JSON.
            existing = _ensure_dynamo_json(existing)

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
        if table_name not in self._tables:
            raise KeyError(f"Table not found: {table_name}")
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
        if table_name not in self._tables:
            raise KeyError(f"Table not found: {table_name}")
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
            raise ValueError(f"Table already exists: {config.table_name}")
        self._tables[config.table_name] = config
        conn = await _setup_table_connection(
            config, self._connections, self._recycled_connections, self._data_dir
        )
        self._connections[config.table_name] = conn

        if config.stream_enabled and self._stream_dispatcher is not None:
            self._configure_stream_for_table(config.table_name, config)

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
        return build_table_description(config)

    # -- Private helpers -------------------------------------------------------

    async def _fetch_item_json(self, conn: aiosqlite.Connection, pk: str, sk: str) -> str | None:
        """Fetch raw item JSON from the items table."""
        return await fetch_item_json(conn, pk, sk)

    async def _update_gsi_entry(
        self,
        conn: aiosqlite.Connection,
        gsi: GsiDefinition,
        item: dict,
        table_config: TableConfig,
    ) -> None:
        """Insert or replace an item in a GSI table with projection support."""
        await update_gsi_entry(conn, gsi, item, table_config)

    async def _delete_gsi_entry(
        self,
        conn: aiosqlite.Connection,
        gsi: GsiDefinition,
        item: dict,
    ) -> None:
        """Delete an item from a GSI table."""
        await delete_gsi_entry(conn, gsi, item)

    def _apply_gsi_projection(
        self, table_name: str, index_name: str, items: list[dict]
    ) -> list[dict]:
        """Apply GSI projection filtering to query results."""
        return apply_gsi_projection(self._tables[table_name], index_name, items)
