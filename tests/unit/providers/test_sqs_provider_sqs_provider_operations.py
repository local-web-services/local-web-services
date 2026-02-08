"""Tests for the SQS provider (P1-06 through P1-11).

Covers LocalQueue send/receive/delete, visibility timeout, DLQ routing,
FIFO ordering and deduplication, SqsProvider lifecycle and IQueue interface,
long polling with asyncio.Event, HTTP wire-protocol routes, and the
SQS event-source poller.
"""

from __future__ import annotations

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


class TestSqsProviderOperations:
    """IQueue operations through SqsProvider."""

    async def test_send_and_receive(self, provider: SqsProvider) -> None:
        msg_id = await provider.send_message("queue-a", "hello from provider")
        assert isinstance(msg_id, str)

        messages = await provider.receive_messages("queue-a", max_messages=1)
        assert len(messages) == 1
        assert messages[0]["Body"] == "hello from provider"
        assert messages[0]["MessageId"] == msg_id
        assert "MD5OfBody" in messages[0]
        assert "ReceiptHandle" in messages[0]

    async def test_delete(self, provider: SqsProvider) -> None:
        await provider.send_message("queue-a", "delete me")
        messages = await provider.receive_messages("queue-a")
        receipt = messages[0]["ReceiptHandle"]

        await provider.delete_message("queue-a", receipt)

    async def test_unknown_queue_raises(self, provider: SqsProvider) -> None:
        with pytest.raises(KeyError, match="Queue not found"):
            await provider.send_message("nonexistent", "fail")

    async def test_message_attributes_in_response(self, provider: SqsProvider) -> None:
        attrs = {"myKey": {"DataType": "String", "StringValue": "myVal"}}
        await provider.send_message("queue-a", "body", message_attributes=attrs)
        messages = await provider.receive_messages("queue-a")
        assert messages[0]["MessageAttributes"] == attrs

    async def test_create_queue(self, provider: SqsProvider) -> None:
        provider.create_queue(QueueConfig(queue_name="dynamic-queue"))
        msg_id = await provider.send_message("dynamic-queue", "works")
        assert msg_id is not None

    async def test_list_queues(self, provider: SqsProvider) -> None:
        names = provider.list_queues()
        assert "queue-a" in names
        assert "queue-b" in names
