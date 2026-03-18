"""WebSocket log handler and helper utilities for LDK logging."""

from __future__ import annotations

import asyncio
from collections import deque
from datetime import datetime
from typing import Any


def _status_style(status: str) -> str:
    """Return a Rich style string for a status or HTTP status code."""
    if status.startswith("2") or status == "OK":
        return "green"
    if status.startswith("4"):
        return "yellow"
    if status.startswith("5") or status == "ERROR":
        return "red"
    return "white"


def _timestamp() -> str:
    """Return the current time as HH:MM:SS."""
    return datetime.now().strftime("%H:%M:%S")


class WebSocketLogHandler:
    """Captures structured log entries and publishes them to WebSocket clients.

    Maintains a bounded deque of recent entries.  On each new entry every
    connected client queue receives the message.  New clients get the full
    backlog first.
    """

    def __init__(self, max_buffer: int = 500) -> None:
        self._buffer: deque[dict[str, Any]] = deque(maxlen=max_buffer)
        self._clients: list[asyncio.Queue[dict[str, Any]]] = []

    def emit(self, entry: dict[str, Any]) -> None:
        """Buffer *entry* and publish to all connected client queues."""
        self._buffer.append(entry)
        for q in self._clients:
            try:
                q.put_nowait(entry)
            except asyncio.QueueFull:
                pass  # drop if client is too slow

    def subscribe(self) -> asyncio.Queue[dict[str, Any]]:
        """Create a new client queue and return it (caller reads from it)."""
        q: asyncio.Queue[dict[str, Any]] = asyncio.Queue(maxsize=1000)
        self._clients.append(q)
        return q

    def unsubscribe(self, q: asyncio.Queue[dict[str, Any]]) -> None:
        """Remove a client queue."""
        try:
            self._clients.remove(q)
        except ValueError:
            pass

    def backlog(self) -> list[dict[str, Any]]:
        """Return a copy of the current buffer."""
        return list(self._buffer)
