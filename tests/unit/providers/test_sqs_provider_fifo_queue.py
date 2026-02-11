"""Tests for the SQS provider (P1-06 through P1-11).

Covers LocalQueue send/receive/delete, visibility timeout, DLQ routing,
FIFO ordering and deduplication, SqsProvider lifecycle and IQueue interface,
long polling with asyncio.Event, HTTP wire-protocol routes, and the
SQS event-source poller.
"""

from __future__ import annotations

import httpx
import pytest

from lws.providers.sqs.provider import QueueConfig, RedrivePolicy, SqsProvider
from lws.providers.sqs.queue import LocalQueue
from lws.providers.sqs.routes import create_sqs_app

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


class TestFifoQueue:
    """FIFO queue ordering and deduplication tests."""

    async def test_fifo_preserves_order(self, fifo_queue: LocalQueue) -> None:
        # Arrange
        expected_bodies = ["msg-0", "msg-1", "msg-2", "msg-3", "msg-4"]
        for i in range(5):
            await fifo_queue.send_message(
                f"msg-{i}",
                message_group_id="group-1",
                message_dedup_id=f"dedup-{i}",
            )

        # Act
        messages = await fifo_queue.receive_messages(max_messages=5)

        # Assert
        actual_bodies = [m.body for m in messages]
        assert actual_bodies == expected_bodies

    async def test_fifo_content_based_dedup(self, fifo_queue: LocalQueue) -> None:
        """Sending the same body twice should deduplicate."""
        # Arrange
        duplicate_body = "duplicate"
        expected_message_count = 1

        # Act
        id1 = await fifo_queue.send_message(duplicate_body, message_group_id="g1")
        id2 = await fifo_queue.send_message(duplicate_body, message_group_id="g1")
        messages = await fifo_queue.receive_messages(max_messages=10)

        # Assert
        assert id1 == id2  # same message returned
        actual_message_count = len(messages)
        assert actual_message_count == expected_message_count

    async def test_fifo_explicit_dedup_id(self) -> None:
        # Arrange
        expected_body = "a"
        expected_message_count = 1
        q = LocalQueue(queue_name="fifo.fifo", is_fifo=True)

        # Act
        id1 = await q.send_message("a", message_group_id="g", message_dedup_id="d1")
        id2 = await q.send_message("b", message_group_id="g", message_dedup_id="d1")
        messages = await q.receive_messages(max_messages=10)

        # Assert
        assert id1 == id2
        actual_message_count = len(messages)
        actual_body = messages[0].body
        assert actual_message_count == expected_message_count
        assert actual_body == expected_body

    async def test_fifo_different_dedup_ids(self) -> None:
        # Arrange
        expected_message_count = 2
        q = LocalQueue(queue_name="fifo.fifo", is_fifo=True)

        # Act
        await q.send_message("a", message_group_id="g", message_dedup_id="d1")
        await q.send_message("b", message_group_id="g", message_dedup_id="d2")
        messages = await q.receive_messages(max_messages=10)

        # Assert
        actual_message_count = len(messages)
        assert actual_message_count == expected_message_count

    async def test_fifo_group_ordering_no_head_of_line_blocking(self) -> None:
        """Messages from different groups should not block each other."""
        # Arrange
        expected_first_body = "g1-m1"
        expected_second_body = "g2-m1"
        q = LocalQueue(queue_name="fifo.fifo", is_fifo=True, visibility_timeout=5)

        await q.send_message("g1-m1", message_group_id="g1", message_dedup_id="g1-1")
        await q.send_message("g1-m2", message_group_id="g1", message_dedup_id="g1-2")
        await q.send_message("g2-m1", message_group_id="g2", message_dedup_id="g2-1")

        # Act
        # Receive first message from g1 (makes g1 invisible)
        msgs = await q.receive_messages(max_messages=1)

        # Assert
        assert len(msgs) == 1
        actual_first_body = msgs[0].body
        assert actual_first_body == expected_first_body

        # Act - g1 is blocked (head message in flight), but g2 should be available
        msgs = await q.receive_messages(max_messages=1)

        # Assert
        assert len(msgs) == 1
        actual_second_body = msgs[0].body
        assert actual_second_body == expected_second_body
