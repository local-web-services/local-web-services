"""S3 event notification dispatcher for local development."""

from __future__ import annotations

import asyncio
import logging
from collections.abc import Callable
from datetime import UTC, datetime

logger = logging.getLogger(__name__)


class NotificationDispatcher:
    """Dispatches S3-style event notifications to registered handlers.

    Supports event types like ``ObjectCreated:*`` and ``ObjectRemoved:*``
    with optional prefix/suffix key filters.
    """

    def __init__(self) -> None:
        self._handlers: list[dict] = []

    def register(
        self,
        bucket: str,
        event_type: str,
        handler: Callable,
        prefix_filter: str = "",
        suffix_filter: str = "",
    ) -> None:
        """Register a handler for a specific bucket and event type.

        Args:
            bucket: The bucket name to listen on.
            event_type: Event type pattern, e.g. ``ObjectCreated:*``.
            handler: An async callable that receives the event record dict.
            prefix_filter: Only dispatch if the key starts with this prefix.
            suffix_filter: Only dispatch if the key ends with this suffix.
        """
        self._handlers.append(
            {
                "bucket": bucket,
                "event_type": event_type,
                "handler": handler,
                "prefix_filter": prefix_filter,
                "suffix_filter": suffix_filter,
            }
        )

    def dispatch(self, bucket: str, event_type: str, key: str) -> None:
        """Evaluate filters and dispatch matching events asynchronously.

        Builds an S3-style event record and dispatches to each matching
        handler via ``asyncio.create_task``.
        """
        record = _build_event_record(bucket, event_type, key)

        for entry in self._handlers:
            if not _matches(entry, bucket, event_type, key):
                continue
            asyncio.create_task(_safe_invoke(entry["handler"], record))


def _matches(entry: dict, bucket: str, event_type: str, key: str) -> bool:
    """Check whether a handler entry matches the given event."""
    if entry["bucket"] != bucket:
        return False
    if not _event_type_matches(entry["event_type"], event_type):
        return False
    if entry["prefix_filter"] and not key.startswith(entry["prefix_filter"]):
        return False
    if entry["suffix_filter"] and not key.endswith(entry["suffix_filter"]):
        return False
    return True


def _event_type_matches(pattern: str, actual: str) -> bool:
    """Match event type patterns like ``ObjectCreated:*`` against ``ObjectCreated:Put``."""
    if pattern == actual:
        return True
    # Wildcard: ``ObjectCreated:*`` matches ``ObjectCreated:Put``
    if pattern.endswith(":*"):
        category = pattern[: -len(":*")]
        return actual.startswith(category + ":")
    return False


def _build_event_record(bucket: str, event_type: str, key: str) -> dict:
    """Build an S3-compatible event record dict."""
    now = datetime.now(UTC).isoformat()
    return {
        "eventVersion": "2.1",
        "eventSource": "ldk:s3",
        "eventTime": now,
        "eventName": f"s3:{event_type}",
        "s3": {
            "bucket": {"name": bucket},
            "object": {"key": key},
        },
    }


async def _safe_invoke(handler: Callable, record: dict) -> None:
    """Invoke a handler, catching and logging any exceptions."""
    try:
        result = handler(record)
        if asyncio.iscoroutine(result):
            await result
    except Exception:
        logger.exception("Error in S3 notification handler")
