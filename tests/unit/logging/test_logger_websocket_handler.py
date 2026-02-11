"""Unit tests for WebSocketLogHandler."""

from __future__ import annotations

import asyncio

import pytest

from lws.logging.logger import WebSocketLogHandler


class TestWebSocketLogHandler:
    """Tests for WebSocketLogHandler buffering and pub/sub."""

    def test_emit_buffers_entry(self):
        # Arrange
        expected_message = "hello"
        expected_backlog_size = 1
        handler = WebSocketLogHandler(max_buffer=10)

        # Act
        handler.emit({"level": "INFO", "message": expected_message})

        # Assert
        actual_backlog_size = len(handler.backlog())
        actual_message = handler.backlog()[0]["message"]
        assert actual_backlog_size == expected_backlog_size
        assert actual_message == expected_message

    def test_buffer_respects_max_size(self):
        # Arrange
        expected_backlog_size = 3
        expected_messages = ["2", "3", "4"]
        handler = WebSocketLogHandler(max_buffer=3)

        # Act
        for i in range(5):
            handler.emit({"message": str(i)})

        # Assert
        backlog = handler.backlog()
        actual_backlog_size = len(backlog)
        actual_messages = [e["message"] for e in backlog]
        assert actual_backlog_size == expected_backlog_size
        assert actual_messages == expected_messages

    def test_backlog_returns_copy(self):
        # Arrange
        expected_backlog_size = 1
        handler = WebSocketLogHandler()
        handler.emit({"message": "a"})

        # Act
        backlog = handler.backlog()
        backlog.append({"message": "b"})

        # Assert
        actual_backlog_size = len(handler.backlog())
        assert actual_backlog_size == expected_backlog_size

    @pytest.mark.asyncio
    async def test_subscribe_receives_new_entries(self):
        # Arrange
        expected_message = "live"
        handler = WebSocketLogHandler()
        q = handler.subscribe()

        # Act
        handler.emit({"message": expected_message})
        entry = q.get_nowait()

        # Assert
        actual_message = entry["message"]
        assert actual_message == expected_message

    @pytest.mark.asyncio
    async def test_multiple_subscribers_receive_same_entry(self):
        # Arrange
        expected_message = "broadcast"
        handler = WebSocketLogHandler()
        q1 = handler.subscribe()
        q2 = handler.subscribe()

        # Act
        handler.emit({"message": expected_message})

        # Assert
        actual_message_q1 = q1.get_nowait()["message"]
        actual_message_q2 = q2.get_nowait()["message"]
        assert actual_message_q1 == expected_message
        assert actual_message_q2 == expected_message

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
        # Arrange
        expected_backlog_size = 1
        handler = WebSocketLogHandler()

        # Act
        handler.emit({"message": "no clients"})

        # Assert
        actual_backlog_size = len(handler.backlog())
        assert actual_backlog_size == expected_backlog_size

    @pytest.mark.asyncio
    async def test_emit_drops_when_queue_full(self):
        # Arrange
        expected_queue_size = 1000
        handler = WebSocketLogHandler()
        q = handler.subscribe()

        # Act — fill the queue to capacity then overflow
        for i in range(1000):
            handler.emit({"message": str(i)})
        handler.emit({"message": "overflow"})

        # Assert
        actual_queue_size = q.qsize()
        assert actual_queue_size == expected_queue_size
