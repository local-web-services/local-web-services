"""SQS state persistence backed by SQLite.

Persists queue state (messages, visibility timeouts, receive counts) to
disk so that messages survive ``ldk dev`` restarts.  Each queue gets its
own SQLite database file under ``<data_dir>/sqs/<queue_name>.db``.
"""

from __future__ import annotations

import json
from pathlib import Path

import aiosqlite

from lws.logging.logger import get_logger
from lws.providers.sqs.queue import SqsMessage

_logger = get_logger("ldk.sqs.persistence")

_CREATE_TABLE_SQL = """
CREATE TABLE IF NOT EXISTS messages (
    message_id TEXT PRIMARY KEY,
    body TEXT NOT NULL,
    attributes TEXT NOT NULL DEFAULT '{}',
    message_attributes TEXT NOT NULL DEFAULT '{}',
    receipt_handle TEXT,
    receive_count INTEGER NOT NULL DEFAULT 0,
    sent_timestamp REAL NOT NULL DEFAULT 0.0,
    visibility_timeout_until REAL NOT NULL DEFAULT 0.0,
    message_group_id TEXT,
    message_dedup_id TEXT
)
"""


class SqsPersistence:
    """SQLite-backed persistence for SQS queue state.

    Args:
        data_dir: Base directory for LDK data files.  Queue databases are
            stored under ``<data_dir>/sqs/``.
    """

    def __init__(self, data_dir: Path) -> None:
        self._data_dir = data_dir
        self._sqs_dir = data_dir / "sqs"

    def _db_path(self, queue_name: str) -> Path:
        """Return the SQLite database path for a given queue."""
        return self._sqs_dir / f"{queue_name}.db"

    async def _ensure_table(self, conn: aiosqlite.Connection) -> None:
        """Create the messages table if it does not exist."""
        await conn.execute(_CREATE_TABLE_SQL)
        await conn.commit()

    async def save_queue_state(self, queue_name: str, messages: list[SqsMessage]) -> None:
        """Persist the current queue state to disk.

        Replaces all existing messages for the queue with the supplied list.

        Args:
            queue_name: Logical queue name.
            messages: List of ``SqsMessage`` objects to persist.
        """
        self._sqs_dir.mkdir(parents=True, exist_ok=True)
        db_path = self._db_path(queue_name)

        async with aiosqlite.connect(str(db_path)) as conn:
            await self._ensure_table(conn)
            await conn.execute("DELETE FROM messages")

            for msg in messages:
                await conn.execute(
                    "INSERT INTO messages "
                    "(message_id, body, attributes, message_attributes, "
                    "receipt_handle, receive_count, sent_timestamp, "
                    "visibility_timeout_until, message_group_id, message_dedup_id) "
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    (
                        msg.message_id,
                        msg.body,
                        json.dumps(msg.attributes),
                        json.dumps(msg.message_attributes),
                        msg.receipt_handle,
                        msg.receive_count,
                        msg.sent_timestamp,
                        msg.visibility_timeout_until,
                        msg.message_group_id,
                        msg.message_dedup_id,
                    ),
                )
            await conn.commit()

        _logger.debug("Saved %d messages for queue %s", len(messages), queue_name)

    async def load_queue_state(self, queue_name: str) -> list[SqsMessage]:
        """Load persisted queue state from disk.

        In-flight messages (those with a visibility timeout in the future)
        have their visibility timeout reset so they become immediately
        available on restart.

        Args:
            queue_name: Logical queue name.

        Returns:
            A list of ``SqsMessage`` objects restored from disk.
        """
        db_path = self._db_path(queue_name)
        if not db_path.exists():
            return []

        messages: list[SqsMessage] = []
        async with aiosqlite.connect(str(db_path)) as conn:
            await self._ensure_table(conn)
            cursor = await conn.execute("SELECT * FROM messages")
            rows = await cursor.fetchall()

            for row in rows:
                msg = SqsMessage(
                    message_id=row[0],
                    body=row[1],
                    attributes=json.loads(row[2]),
                    message_attributes=json.loads(row[3]),
                    receipt_handle=row[4],
                    receive_count=row[5],
                    sent_timestamp=row[6],
                    visibility_timeout_until=0.0,  # Reset on restart
                    message_group_id=row[8],
                    message_dedup_id=row[9],
                )
                messages.append(msg)

        _logger.debug("Loaded %d messages for queue %s", len(messages), queue_name)
        return messages

    async def reset(self, queue_name: str) -> None:
        """Delete all persisted state for a queue.

        Args:
            queue_name: Logical queue name.
        """
        db_path = self._db_path(queue_name)
        if db_path.exists():
            db_path.unlink()
            _logger.info("Reset state for queue %s", queue_name)

    async def reset_all(self) -> None:
        """Delete all persisted SQS state across all queues."""
        if not self._sqs_dir.exists():
            return
        for db_file in self._sqs_dir.glob("*.db"):
            db_file.unlink()
            _logger.info("Deleted %s", db_file.name)
