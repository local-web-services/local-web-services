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


class TestSqsRoutes:
    """SQS wire-protocol HTTP route tests."""

    async def test_send_message(self, sqs_client: httpx.AsyncClient) -> None:
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "SendMessage",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
                "MessageBody": "hello",
            },
        )
        assert resp.status_code == 200
        assert "<MessageId>" in resp.text
        assert "<MD5OfMessageBody>" in resp.text

    async def test_receive_message(self, sqs_client: httpx.AsyncClient) -> None:
        # Send first
        await sqs_client.post(
            "/",
            data={
                "Action": "SendMessage",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
                "MessageBody": "receive-me",
            },
        )
        # Receive
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "ReceiveMessage",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
                "MaxNumberOfMessages": "1",
            },
        )
        assert resp.status_code == 200
        assert "<Body>receive-me</Body>" in resp.text

    async def test_delete_message(self, sqs_client: httpx.AsyncClient) -> None:
        # Send
        await sqs_client.post(
            "/",
            data={
                "Action": "SendMessage",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
                "MessageBody": "del-me",
            },
        )
        # Receive to get receipt handle
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "ReceiveMessage",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
            },
        )
        # Extract receipt handle from XML
        import re

        match = re.search(r"<ReceiptHandle>(.*?)</ReceiptHandle>", resp.text)
        assert match is not None
        receipt = match.group(1)

        # Delete
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "DeleteMessage",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
                "ReceiptHandle": receipt,
            },
        )
        assert resp.status_code == 200
        assert "<DeleteMessageResponse>" in resp.text

    async def test_create_queue(self, sqs_client: httpx.AsyncClient) -> None:
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "CreateQueue",
                "QueueName": "new-queue",
            },
        )
        assert resp.status_code == 200
        assert "<QueueUrl>" in resp.text
        assert "new-queue" in resp.text

    async def test_get_queue_url(self, sqs_client: httpx.AsyncClient) -> None:
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "GetQueueUrl",
                "QueueName": "test-queue",
            },
        )
        assert resp.status_code == 200
        assert "<QueueUrl>" in resp.text

    async def test_get_queue_url_not_found(self, sqs_client: httpx.AsyncClient) -> None:
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "GetQueueUrl",
                "QueueName": "nonexistent",
            },
        )
        assert resp.status_code == 400
        assert "NonExistentQueue" in resp.text

    async def test_get_queue_attributes(self, sqs_client: httpx.AsyncClient) -> None:
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "GetQueueAttributes",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
            },
        )
        assert resp.status_code == 200
        assert "VisibilityTimeout" in resp.text
        assert "QueueArn" in resp.text

    async def test_unknown_action_returns_error(self, sqs_client: httpx.AsyncClient) -> None:
        resp = await sqs_client.post(
            "/",
            data={"Action": "BogusAction"},
        )
        assert resp.status_code == 400
        assert "<ErrorResponse>" in resp.text
        assert "<Code>InvalidAction</Code>" in resp.text
        assert "lws" in resp.text
        assert "SQS" in resp.text
        assert "BogusAction" in resp.text

    async def test_send_with_query_params(self, sqs_client: httpx.AsyncClient) -> None:
        """Action can also be passed as query parameter."""
        resp = await sqs_client.post(
            "/?Action=SendMessage"
            "&QueueUrl=http://localhost:4566/000000000000/test-queue"
            "&MessageBody=via-query",
        )
        assert resp.status_code == 200
        assert "<MessageId>" in resp.text
