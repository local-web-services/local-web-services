"""Unit tests for WebSocketLogHandler."""

from __future__ import annotations

import asyncio

import pytest

from lws.logging.logger import WebSocketLogHandler


class TestWebSocketLogHandler:
    """Tests for WebSocketLogHandler buffering and pub/sub."""

    def test_emit_buffers_entry(self):
        handler = WebSocketLogHandler(max_buffer=10)
        handler.emit({"level": "INFO", "message": "hello"})
        assert len(handler.backlog()) == 1
        assert handler.backlog()[0]["message"] == "hello"

    def test_buffer_respects_max_size(self):
        handler = WebSocketLogHandler(max_buffer=3)
        for i in range(5):
            handler.emit({"message": str(i)})
        backlog = handler.backlog()
        assert len(backlog) == 3
        assert [e["message"] for e in backlog] == ["2", "3", "4"]

    def test_backlog_returns_copy(self):
        handler = WebSocketLogHandler()
        handler.emit({"message": "a"})
        backlog = handler.backlog()
        backlog.append({"message": "b"})
        assert len(handler.backlog()) == 1

    @pytest.mark.asyncio
    async def test_subscribe_receives_new_entries(self):
        handler = WebSocketLogHandler()
        q = handler.subscribe()
        handler.emit({"message": "live"})
        entry = q.get_nowait()
        assert entry["message"] == "live"

    @pytest.mark.asyncio
    async def test_multiple_subscribers_receive_same_entry(self):
        handler = WebSocketLogHandler()
        q1 = handler.subscribe()
        q2 = handler.subscribe()
        handler.emit({"message": "broadcast"})
        assert q1.get_nowait()["message"] == "broadcast"
        assert q2.get_nowait()["message"] == "broadcast"

    @pytest.mark.asyncio
    async def test_unsubscribe_stops_delivery(self):
        handler = WebSocketLogHandler()
        q = handler.subscribe()
        handler.unsubscribe(q)
        handler.emit({"message": "after-unsub"})
        assert q.empty()

    @pytest.mark.asyncio
    async def test_unsubscribe_nonexistent_queue_is_safe(self):
        handler = WebSocketLogHandler()
        q: asyncio.Queue = asyncio.Queue()
        handler.unsubscribe(q)  # should not raise

    def test_emit_with_no_subscribers_does_not_error(self):
        handler = WebSocketLogHandler()
        handler.emit({"message": "no clients"})
        assert len(handler.backlog()) == 1

    @pytest.mark.asyncio
    async def test_emit_drops_when_queue_full(self):
        handler = WebSocketLogHandler()
        q = handler.subscribe()
        # Fill the queue to capacity (1000)
        for i in range(1000):
            handler.emit({"message": str(i)})
        # This should not raise — just drop
        handler.emit({"message": "overflow"})
        assert q.qsize() == 1000
