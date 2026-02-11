"""DynamoDB Streams emulation.

Emits INSERT, MODIFY, REMOVE events on data changes and dispatches
them to registered Lambda handlers in batches.

StreamViewType support:
- KEYS_ONLY: only key attributes
- NEW_IMAGE: full item after modification
- OLD_IMAGE: full item before modification
- NEW_AND_OLD_IMAGES: both old and new images
"""

from __future__ import annotations

import asyncio
import logging
import time
import uuid
from collections.abc import Callable, Coroutine
from dataclasses import dataclass, field
from enum import StrEnum
from typing import Any

logger = logging.getLogger(__name__)


# ---------------------------------------------------------------------------
# Types
# ---------------------------------------------------------------------------


class EventName(StrEnum):
    """DynamoDB stream event types."""

    INSERT = "INSERT"
    MODIFY = "MODIFY"
    REMOVE = "REMOVE"


class StreamViewType(StrEnum):
    """What data is included in stream records."""

    KEYS_ONLY = "KEYS_ONLY"
    NEW_IMAGE = "NEW_IMAGE"
    OLD_IMAGE = "OLD_IMAGE"
    NEW_AND_OLD_IMAGES = "NEW_AND_OLD_IMAGES"


@dataclass
class StreamRecord:
    """A single DynamoDB stream record."""

    event_id: str
    event_name: EventName
    table_name: str
    keys: dict[str, Any]
    new_image: dict[str, Any] | None = None
    old_image: dict[str, Any] | None = None
    sequence_number: str = ""
    approximate_creation_datetime: float = 0.0

    def to_dynamodb_event_record(self) -> dict[str, Any]:
        """Convert to the format expected by Lambda stream event handlers."""
        record: dict[str, Any] = {
            "eventID": self.event_id,
            "eventName": self.event_name.value,
            "eventVersion": "1.1",
            "eventSource": "aws:dynamodb",
            "awsRegion": "local",
            "dynamodb": {
                "Keys": self.keys,
                "SequenceNumber": self.sequence_number,
                "SizeBytes": 0,
                "StreamViewType": "NEW_AND_OLD_IMAGES",
                "ApproximateCreationDateTime": self.approximate_creation_datetime,
            },
            "eventSourceARN": f"arn:aws:dynamodb:local:000000000000:table/{self.table_name}/stream",
        }
        dynamodb = record["dynamodb"]
        if self.new_image is not None:
            dynamodb["NewImage"] = self.new_image
        if self.old_image is not None:
            dynamodb["OldImage"] = self.old_image
        return record


@dataclass
class StreamConfiguration:
    """Configuration for a table's stream."""

    table_name: str
    view_type: StreamViewType = StreamViewType.NEW_AND_OLD_IMAGES
    key_attributes: list[str] = field(default_factory=list)


# Type alias for Lambda handler callables
LambdaHandler = Callable[[dict[str, Any]], Coroutine[Any, Any, Any]]


# ---------------------------------------------------------------------------
# Stream record builder
# ---------------------------------------------------------------------------


def _next_sequence_number() -> str:
    """Generate a monotonically increasing sequence number."""
    return str(int(time.monotonic() * 1_000_000))


def build_stream_record(
    event_name: EventName,
    table_name: str,
    keys: dict[str, Any],
    new_image: dict[str, Any] | None,
    old_image: dict[str, Any] | None,
    view_type: StreamViewType,
    key_attributes: list[str],
) -> StreamRecord:
    """Build a StreamRecord applying the view type filter."""
    filtered_new = _filter_image(new_image, view_type, key_attributes, is_new=True)
    filtered_old = _filter_image(old_image, view_type, key_attributes, is_new=False)

    return StreamRecord(
        event_id=str(uuid.uuid4()),
        event_name=event_name,
        table_name=table_name,
        keys=keys,
        new_image=filtered_new,
        old_image=filtered_old,
        sequence_number=_next_sequence_number(),
        approximate_creation_datetime=time.time(),
    )


def _filter_image(
    image: dict[str, Any] | None,
    view_type: StreamViewType,
    _key_attributes: list[str],
    is_new: bool,
) -> dict[str, Any] | None:
    """Filter an image based on the stream view type."""
    if image is None:
        return None

    if view_type == StreamViewType.KEYS_ONLY:
        return None

    if view_type == StreamViewType.NEW_IMAGE:
        return image if is_new else None

    if view_type == StreamViewType.OLD_IMAGE:
        return image if not is_new else None

    # NEW_AND_OLD_IMAGES
    return image


# ---------------------------------------------------------------------------
# StreamDispatcher
# ---------------------------------------------------------------------------


class StreamDispatcher:
    """Buffers DynamoDB stream events and dispatches them to Lambda handlers.

    Events are buffered for a configurable duration (default 100ms), then
    batch-invoked against all registered handlers.

    Parameters
    ----------
    batch_window_ms : int
        How long to buffer events before flushing, in milliseconds.
    max_batch_size : int
        Maximum number of records per batch invocation.
    """

    def __init__(
        self,
        batch_window_ms: int = 100,
        max_batch_size: int = 100,
    ) -> None:
        self._batch_window_ms = batch_window_ms
        self._max_batch_size = max_batch_size
        self._handlers: dict[str, list[LambdaHandler]] = {}
        self._configurations: dict[str, StreamConfiguration] = {}
        self._queue: asyncio.Queue[StreamRecord] = asyncio.Queue()
        self._flush_task: asyncio.Task[None] | None = None
        self._running = False
        self._collected_records: list[StreamRecord] = []

    def configure_stream(self, config: StreamConfiguration) -> None:
        """Register a stream configuration for a table."""
        self._configurations[config.table_name] = config

    def register_handler(self, table_name: str, handler: LambdaHandler) -> None:
        """Register a Lambda handler for stream events from a table."""
        if table_name not in self._handlers:
            self._handlers[table_name] = []
        self._handlers[table_name].append(handler)

    async def start(self) -> None:
        """Start the background flush task."""
        if self._running:
            return
        self._running = True
        self._flush_task = asyncio.create_task(self._flush_loop())

    async def stop(self) -> None:
        """Stop the dispatcher, flushing any remaining events."""
        self._running = False
        if self._flush_task is not None:
            self._flush_task.cancel()
            try:
                await self._flush_task
            except asyncio.CancelledError:
                pass
            self._flush_task = None
        # Flush any remaining records
        await self._flush_pending()

    async def emit(
        self,
        event_name: EventName,
        table_name: str,
        keys: dict[str, Any],
        new_image: dict[str, Any] | None = None,
        old_image: dict[str, Any] | None = None,
    ) -> None:
        """Emit a stream event.

        Called by the provider on put/update/delete operations.
        """
        config = self._configurations.get(table_name)
        if config is None:
            return  # No stream configured for this table

        handlers = self._handlers.get(table_name)
        if not handlers:
            return  # No handlers registered

        record = build_stream_record(
            event_name=event_name,
            table_name=table_name,
            keys=keys,
            new_image=new_image,
            old_image=old_image,
            view_type=config.view_type,
            key_attributes=config.key_attributes,
        )
        await self._queue.put(record)

    async def _flush_loop(self) -> None:
        """Background loop that collects events and flushes them periodically."""
        window_seconds = self._batch_window_ms / 1000.0
        while self._running:
            try:
                await self._collect_for_window(window_seconds)
                await self._flush_pending()
            except Exception:
                logger.exception("Error in stream flush loop")

    async def _collect_for_window(self, window_seconds: float) -> None:
        """Collect records from the queue for the duration of one batch window."""
        deadline = asyncio.get_event_loop().time() + window_seconds
        while True:
            remaining = deadline - asyncio.get_event_loop().time()
            if remaining <= 0:
                break
            try:
                record = await asyncio.wait_for(self._queue.get(), timeout=remaining)
                self._collected_records.append(record)
                if len(self._collected_records) >= self._max_batch_size:
                    break
            except TimeoutError:
                break

    async def _flush_pending(self) -> None:
        """Flush all collected records, draining the queue first."""
        self._drain_queue()
        if not self._collected_records:
            return
        records = self._collected_records
        self._collected_records = []
        await self._dispatch_batches(records)

    def _drain_queue(self) -> None:
        """Drain any remaining items from the queue into collected records."""
        while not self._queue.empty():
            try:
                record = self._queue.get_nowait()
                self._collected_records.append(record)
            except asyncio.QueueEmpty:
                break

    async def _dispatch_batches(self, records: list[StreamRecord]) -> None:
        """Dispatch records to handlers, grouped by table and batched."""
        by_table = _group_by_table(records)
        tasks: list[Coroutine[Any, Any, None]] = []
        for table_name, table_records in by_table.items():
            handlers = self._handlers.get(table_name, [])
            batches = _split_into_batches(table_records, self._max_batch_size)
            for batch in batches:
                for handler in handlers:
                    tasks.append(self._invoke_handler(handler, table_name, batch))
        if tasks:
            await asyncio.gather(*tasks, return_exceptions=True)

    async def _invoke_handler(
        self,
        handler: LambdaHandler,
        table_name: str,
        records: list[StreamRecord],
    ) -> None:
        """Invoke a single handler with a batch of stream records."""
        event = _build_lambda_event(records)
        try:
            await handler(event)
        except Exception:
            logger.exception(
                "Stream handler error for table %s with %d records",
                table_name,
                len(records),
            )


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _group_by_table(records: list[StreamRecord]) -> dict[str, list[StreamRecord]]:
    """Group stream records by table name."""
    groups: dict[str, list[StreamRecord]] = {}
    for record in records:
        if record.table_name not in groups:
            groups[record.table_name] = []
        groups[record.table_name].append(record)
    return groups


def _split_into_batches(records: list[StreamRecord], max_size: int) -> list[list[StreamRecord]]:
    """Split a list of records into batches of at most max_size."""
    return [records[i : i + max_size] for i in range(0, len(records), max_size)]


def _build_lambda_event(records: list[StreamRecord]) -> dict[str, Any]:
    """Build a DynamoDB Streams Lambda event payload from a list of records."""
    return {
        "Records": [r.to_dynamodb_event_record() for r in records],
    }
