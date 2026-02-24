"""Tests for the SQS provider (P1-06 through P1-11).

Covers LocalQueue send/receive/delete, visibility timeout, DLQ routing,
FIFO ordering and deduplication, SqsProvider lifecycle and IQueue interface,
long polling with asyncio.Event, HTTP wire-protocol routes, and the
SQS event-source poller.
"""

from __future__ import annotations

import asyncio
from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces.compute import ICompute, InvocationResult
from lws.interfaces.queue import IQueue
from lws.providers.sqs.event_source import EventSourceMapping, SqsEventSourcePoller
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


class TestSqsEventSourcePoller:
    """SQS event-source poller invocation tests."""

    async def test_poller_invokes_function(self) -> None:
        """Poller receives messages and invokes the correct Lambda function."""
        # Arrange
        expected_body = '{"key": "value"}'
        expected_event_source = "aws:sqs"
        queue_name = "poll-queue"
        function_name = "my-function"

        queue_provider = SqsProvider(
            queues=[QueueConfig(queue_name=queue_name, visibility_timeout=30)]
        )
        await queue_provider.start()

        await queue_provider.send_message(queue_name, expected_body)

        mock_compute = AsyncMock(spec=ICompute)
        mock_compute.invoke.return_value = InvocationResult(
            payload={"statusCode": 200},
            error=None,
            duration_ms=50.0,
            request_id="req-123",
        )

        mapping = EventSourceMapping(
            queue_name=queue_name,
            function_name=function_name,
            batch_size=10,
        )

        poller = SqsEventSourcePoller(
            queue_provider=queue_provider,
            compute_providers={function_name: mock_compute},
            mappings=[mapping],
            poll_interval=0.1,
        )

        # Act
        await poller.start()
        await asyncio.sleep(0.5)
        await poller.stop()

        # Assert
        mock_compute.invoke.assert_called()
        call_args = mock_compute.invoke.call_args
        event = call_args[0][0]
        assert "Records" in event
        assert len(event["Records"]) >= 1
        actual_body = event["Records"][0]["body"]
        actual_event_source = event["Records"][0]["eventSource"]
        assert actual_body == expected_body
        assert actual_event_source == expected_event_source

        await queue_provider.stop()

    async def test_poller_deletes_on_success(self) -> None:
        """Successful invocation should delete messages."""
        # Arrange
        queue_name = "del-queue"
        function_name = "fn"
        expected_remaining_count = 0

        queue_provider = SqsProvider(
            queues=[QueueConfig(queue_name=queue_name, visibility_timeout=30)]
        )
        await queue_provider.start()

        await queue_provider.send_message(queue_name, "delete-after-invoke")

        mock_compute = AsyncMock(spec=ICompute)
        mock_compute.invoke.return_value = InvocationResult(
            payload={}, error=None, duration_ms=10.0, request_id="r1"
        )

        mapping = EventSourceMapping(
            queue_name=queue_name,
            function_name=function_name,
            batch_size=1,
        )

        poller = SqsEventSourcePoller(
            queue_provider=queue_provider,
            compute_providers={function_name: mock_compute},
            mappings=[mapping],
            poll_interval=0.1,
        )

        # Act
        await poller.start()
        await asyncio.sleep(0.5)
        await poller.stop()

        # Assert
        msgs = await queue_provider.receive_messages(queue_name, max_messages=10)
        actual_remaining_count = len(msgs)
        assert actual_remaining_count == expected_remaining_count

        await queue_provider.stop()

    async def test_poller_retains_on_failure(self) -> None:
        """Failed invocation should leave messages in the queue."""
        # Arrange
        queue_name = "fail-queue"
        function_name = "fn"

        queue_provider = SqsProvider(
            queues=[QueueConfig(queue_name=queue_name, visibility_timeout=1)]
        )
        await queue_provider.start()

        await queue_provider.send_message(queue_name, "keep-on-fail")

        mock_compute = AsyncMock(spec=ICompute)
        mock_compute.invoke.return_value = InvocationResult(
            payload=None, error="Lambda failed", duration_ms=10.0, request_id="r1"
        )

        mapping = EventSourceMapping(
            queue_name=queue_name,
            function_name=function_name,
            batch_size=1,
        )

        poller = SqsEventSourcePoller(
            queue_provider=queue_provider,
            compute_providers={function_name: mock_compute},
            mappings=[mapping],
            poll_interval=0.1,
        )

        # Act
        await poller.start()
        await asyncio.sleep(0.3)
        await poller.stop()

        # Wait for visibility timeout
        await asyncio.sleep(1.2)

        # Assert
        msgs = await queue_provider.receive_messages(queue_name, max_messages=10)
        assert len(msgs) >= 1

        await queue_provider.stop()

    async def test_poller_start_stop(self) -> None:
        """Poller can start and stop cleanly."""
        # Arrange
        expected_task_count_after_start = 1
        expected_task_count_after_stop = 0
        queue_provider = AsyncMock(spec=IQueue)
        queue_provider.receive_messages.return_value = []

        mapping = EventSourceMapping(
            queue_name="q",
            function_name="fn",
            batch_size=1,
        )

        poller = SqsEventSourcePoller(
            queue_provider=queue_provider,
            compute_providers={},
            mappings=[mapping],
            poll_interval=0.1,
        )

        # Act / Assert - start
        await poller.start()
        assert poller._running is True
        actual_task_count_after_start = len(poller._tasks)
        assert actual_task_count_after_start == expected_task_count_after_start

        # Act / Assert - stop
        await poller.stop()
        assert poller._running is False
        actual_task_count_after_stop = len(poller._tasks)
        assert actual_task_count_after_stop == expected_task_count_after_stop

    async def test_poller_disabled_mapping_skipped(self) -> None:
        """Disabled mappings should not create polling tasks."""
        # Arrange
        expected_task_count = 0
        queue_provider = AsyncMock(spec=IQueue)

        mapping = EventSourceMapping(
            queue_name="q",
            function_name="fn",
            batch_size=1,
            enabled=False,
        )

        poller = SqsEventSourcePoller(
            queue_provider=queue_provider,
            compute_providers={},
            mappings=[mapping],
            poll_interval=0.1,
        )

        # Act
        await poller.start()

        # Assert
        actual_task_count = len(poller._tasks)
        assert actual_task_count == expected_task_count
        await poller.stop()
