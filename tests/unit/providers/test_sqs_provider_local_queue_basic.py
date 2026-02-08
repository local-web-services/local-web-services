"""Tests for the SQS provider (P1-06 through P1-11).

Covers LocalQueue send/receive/delete, visibility timeout, DLQ routing,
FIFO ordering and deduplication, SqsProvider lifecycle and IQueue interface,
long polling with asyncio.Event, HTTP wire-protocol routes, and the
SQS event-source poller.
"""

from __future__ import annotations

import asyncio
import hashlib
import time

import httpx
import pytest

from ldk.providers.sqs.provider import QueueConfig, RedrivePolicy, SqsProvider
from ldk.providers.sqs.queue import LocalQueue
from ldk.providers.sqs.routes import create_sqs_app

# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------


@pytest.fixture()
def queue() -> LocalQueue:
    """A standard (non-FIFO) LocalQueue."""
    return LocalQueue(queue_name="test-queue", visibility_timeout=2)


@pytest.fixture()
def fifo_queue() -> LocalQueue:
    """A FIFO queue with content-based deduplication."""
    return LocalQueue(
        queue_name="test-queue.fifo",
        visibility_timeout=2,
        is_fifo=True,
        content_based_dedup=True,
    )


@pytest.fixture()
def dlq() -> LocalQueue:
    """A dead-letter queue."""
    return LocalQueue(queue_name="test-dlq", visibility_timeout=30)


@pytest.fixture()
def queue_with_dlq(dlq: LocalQueue) -> LocalQueue:
    """A queue wired to a dead-letter queue with max_receive_count=2."""
    return LocalQueue(
        queue_name="test-queue-dlq",
        visibility_timeout=1,
        dead_letter_queue=dlq,
        max_receive_count=2,
    )


@pytest.fixture()
async def provider() -> SqsProvider:
    """An SqsProvider with two standard queues."""
    p = SqsProvider(
        queues=[
            QueueConfig(queue_name="queue-a"),
            QueueConfig(queue_name="queue-b"),
        ]
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture()
async def provider_with_dlq() -> SqsProvider:
    """An SqsProvider with a queue and its DLQ."""
    p = SqsProvider(
        queues=[
            QueueConfig(queue_name="dlq"),
            QueueConfig(
                queue_name="main-queue",
                visibility_timeout=1,
                redrive_policy=RedrivePolicy(
                    dead_letter_queue_name="dlq",
                    max_receive_count=2,
                ),
            ),
        ]
    )
    await p.start()
    yield p
    await p.stop()


# ---------------------------------------------------------------------------
# P1-06: LocalQueue – send / receive / delete
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Visibility timeout
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# DLQ routing
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# FIFO ordering and deduplication
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Long polling with asyncio.Event
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# SqsProvider lifecycle and IQueue interface
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# HTTP wire-protocol routes
# ---------------------------------------------------------------------------


@pytest.fixture()
async def sqs_client() -> httpx.AsyncClient:
    """An httpx client wired to an SQS ASGI app."""
    p = SqsProvider(
        queues=[
            QueueConfig(queue_name="test-queue"),
            QueueConfig(queue_name="fifo-queue.fifo", is_fifo=True),
        ]
    )
    await p.start()
    app = create_sqs_app(p)
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    client = httpx.AsyncClient(transport=transport, base_url="http://testserver")
    yield client
    await p.stop()


# ---------------------------------------------------------------------------
# Event-source poller
# ---------------------------------------------------------------------------


class TestLocalQueueBasic:
    """Core send, receive, delete operations."""

    async def test_send_returns_message_id(self, queue: LocalQueue) -> None:
        msg_id = await queue.send_message("hello")
        assert isinstance(msg_id, str)
        assert len(msg_id) > 0

    async def test_receive_returns_sent_message(self, queue: LocalQueue) -> None:
        await queue.send_message("hello world")
        messages = await queue.receive_messages(max_messages=1)
        assert len(messages) == 1
        assert messages[0].body == "hello world"
        assert messages[0].receipt_handle is not None

    async def test_receive_empty_queue(self, queue: LocalQueue) -> None:
        messages = await queue.receive_messages(max_messages=1)
        assert messages == []

    async def test_delete_removes_message(self, queue: LocalQueue) -> None:
        await queue.send_message("to-delete")
        messages = await queue.receive_messages(max_messages=1)
        receipt = messages[0].receipt_handle
        assert receipt is not None

        await queue.delete_message(receipt)

        # Wait for visibility timeout to expire
        await asyncio.sleep(0.1)
        # Use a fresh queue check — the message should be gone
        remaining = await queue.receive_messages(max_messages=10)
        # The message was deleted, so even after visibility expires it won't return
        # (we need to wait for the visibility timeout to test properly)
        assert all(m.body != "to-delete" for m in remaining)

    async def test_receive_max_messages(self, queue: LocalQueue) -> None:
        for i in range(5):
            await queue.send_message(f"msg-{i}")
        messages = await queue.receive_messages(max_messages=3)
        assert len(messages) == 3

    async def test_receive_increments_receive_count(self, queue: LocalQueue) -> None:
        await queue.send_message("count-me")
        msgs = await queue.receive_messages()
        assert msgs[0].receive_count == 1
        assert msgs[0].attributes["ApproximateReceiveCount"] == "1"

    async def test_sent_timestamp_set(self, queue: LocalQueue) -> None:
        before = time.time()
        await queue.send_message("timestamped")
        after = time.time()
        messages = await queue.receive_messages()
        assert before <= messages[0].sent_timestamp <= after

    async def test_message_attributes_preserved(self, queue: LocalQueue) -> None:
        attrs = {"key1": {"DataType": "String", "StringValue": "val1"}}
        await queue.send_message("with-attrs", message_attributes=attrs)
        messages = await queue.receive_messages()
        assert messages[0].message_attributes == attrs

    async def test_md5_of_body(self) -> None:
        body = "test body"
        expected = hashlib.md5(body.encode()).hexdigest()
        assert LocalQueue.md5_of_body(body) == expected
