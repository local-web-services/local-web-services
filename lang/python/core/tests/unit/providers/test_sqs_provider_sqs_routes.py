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
        # Arrange
        expected_status_code = 200
        queue_url = "http://localhost:4566/000000000000/test-queue"

        # Act
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "SendMessage",
                "QueueUrl": queue_url,
                "MessageBody": "hello",
            },
        )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        assert "<MessageId>" in resp.text, f'Expected {"<MessageId>"!r} to be in {resp.text!r}'
        assert (
            "<MD5OfMessageBody>" in resp.text
        ), f'Expected {"<MD5OfMessageBody>"!r} to be in {resp.text!r}'

    async def test_receive_message(self, sqs_client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200
        expected_body = "receive-me"
        queue_url = "http://localhost:4566/000000000000/test-queue"

        await sqs_client.post(
            "/",
            data={
                "Action": "SendMessage",
                "QueueUrl": queue_url,
                "MessageBody": expected_body,
            },
        )

        # Act
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "ReceiveMessage",
                "QueueUrl": queue_url,
                "MaxNumberOfMessages": "1",
            },
        )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        assert f"<Body>{expected_body}</Body>" in resp.text, "Expected {!r} to be in {!r}".format(
            f"<Body>{expected_body}</Body>", resp.text
        )

    async def test_delete_message(self, sqs_client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200
        queue_url = "http://localhost:4566/000000000000/test-queue"

        await sqs_client.post(
            "/",
            data={
                "Action": "SendMessage",
                "QueueUrl": queue_url,
                "MessageBody": "del-me",
            },
        )
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "ReceiveMessage",
                "QueueUrl": queue_url,
            },
        )
        import re

        match = re.search(r"<ReceiptHandle>(.*?)</ReceiptHandle>", resp.text)
        assert match is not None, "Expected value to be set but was None"
        receipt = match.group(1)

        # Act
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "DeleteMessage",
                "QueueUrl": queue_url,
                "ReceiptHandle": receipt,
            },
        )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        assert (
            "<DeleteMessageResponse>" in resp.text
        ), f'Expected {"<DeleteMessageResponse>"!r} to be in {resp.text!r}'

    async def test_create_queue(self, sqs_client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200
        queue_name = "new-queue"

        # Act
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "CreateQueue",
                "QueueName": queue_name,
            },
        )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        assert "<QueueUrl>" in resp.text, f'Expected {"<QueueUrl>"!r} to be in {resp.text!r}'
        assert queue_name in resp.text, f"Expected {queue_name!r} to be in {resp.text!r}"

    async def test_get_queue_url(self, sqs_client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200

        # Act
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "GetQueueUrl",
                "QueueName": "test-queue",
            },
        )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        assert "<QueueUrl>" in resp.text, f'Expected {"<QueueUrl>"!r} to be in {resp.text!r}'

    async def test_get_queue_url_not_found(self, sqs_client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400

        # Act
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "GetQueueUrl",
                "QueueName": "nonexistent",
            },
        )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        assert (
            "NonExistentQueue" in resp.text
        ), f'Expected {"NonExistentQueue"!r} to be in {resp.text!r}'

    async def test_get_queue_attributes(self, sqs_client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200

        # Act
        resp = await sqs_client.post(
            "/",
            data={
                "Action": "GetQueueAttributes",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
            },
        )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        assert (
            "VisibilityTimeout" in resp.text
        ), f'Expected {"VisibilityTimeout"!r} to be in {resp.text!r}'
        assert "QueueArn" in resp.text, f'Expected {"QueueArn"!r} to be in {resp.text!r}'

    async def test_unknown_action_returns_error(self, sqs_client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400
        bogus_action = "BogusAction"

        # Act
        resp = await sqs_client.post(
            "/",
            data={"Action": bogus_action},
        )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        assert (
            "<ErrorResponse>" in resp.text
        ), f'Expected {"<ErrorResponse>"!r} to be in {resp.text!r}'
        assert (
            "<Code>InvalidAction</Code>" in resp.text
        ), f'Expected {"<Code>InvalidAction</Code>"!r} to be in {resp.text!r}'
        assert "lws" in resp.text, f'Expected {"lws"!r} to be in {resp.text!r}'
        assert "SQS" in resp.text, f'Expected {"SQS"!r} to be in {resp.text!r}'
        assert bogus_action in resp.text, f"Expected {bogus_action!r} to be in {resp.text!r}"

    async def test_send_with_query_params(self, sqs_client: httpx.AsyncClient) -> None:
        """Action can also be passed as query parameter."""
        # Arrange
        expected_status_code = 200

        # Act
        resp = await sqs_client.post(
            "/?Action=SendMessage"
            "&QueueUrl=http://localhost:4566/000000000000/test-queue"
            "&MessageBody=via-query",
        )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        assert "<MessageId>" in resp.text, f'Expected {"<MessageId>"!r} to be in {resp.text!r}'
