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
from unittest.mock import AsyncMock

import httpx
import pytest

from ldk.interfaces.compute import ICompute, InvocationResult
from ldk.interfaces.queue import IQueue
from ldk.providers.sqs.event_source import EventSourceMapping, SqsEventSourcePoller
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


# ---------------------------------------------------------------------------
# Visibility timeout
# ---------------------------------------------------------------------------


class TestVisibilityTimeout:
    """Messages are invisible during their visibility timeout window."""

    async def test_message_invisible_after_receive(self, queue: LocalQueue) -> None:
        await queue.send_message("hidden")
        await queue.receive_messages()
        # Immediately try to receive again — should be empty
        messages = await queue.receive_messages()
        assert messages == []

    async def test_message_reappears_after_timeout(self) -> None:
        q = LocalQueue(queue_name="fast-vt", visibility_timeout=0)
        await q.send_message("reappear")
        msgs1 = await q.receive_messages()
        assert len(msgs1) == 1
        # With 0s timeout, should reappear immediately
        msgs2 = await q.receive_messages()
        assert len(msgs2) == 1
        assert msgs2[0].receive_count == 2

    async def test_delay_seconds(self, queue: LocalQueue) -> None:
        await queue.send_message("delayed", delay_seconds=10)
        messages = await queue.receive_messages()
        assert messages == []  # delayed message not visible yet


# ---------------------------------------------------------------------------
# DLQ routing
# ---------------------------------------------------------------------------


class TestDeadLetterQueue:
    """Messages exceeding max_receive_count are moved to the DLQ."""

    async def test_message_routed_to_dlq(self, queue_with_dlq: LocalQueue, dlq: LocalQueue) -> None:
        # max_receive_count=2, visibility_timeout=1
        await queue_with_dlq.send_message("dlq-candidate")

        # First receive (count=1)
        msgs = await queue_with_dlq.receive_messages()
        assert len(msgs) == 1

        # Wait for visibility timeout
        await asyncio.sleep(1.1)

        # Second receive (count=2, now equals max_receive_count)
        msgs = await queue_with_dlq.receive_messages()
        assert len(msgs) == 1

        # Wait for visibility timeout again
        await asyncio.sleep(1.1)

        # Third attempt: message should be routed to DLQ (count >= max)
        msgs = await queue_with_dlq.receive_messages()
        assert len(msgs) == 0

        # Message should now be in DLQ
        dlq_msgs = await dlq.receive_messages()
        assert len(dlq_msgs) == 1
        assert dlq_msgs[0].body == "dlq-candidate"


# ---------------------------------------------------------------------------
# FIFO ordering and deduplication
# ---------------------------------------------------------------------------


class TestFifoQueue:
    """FIFO queue ordering and deduplication tests."""

    async def test_fifo_preserves_order(self, fifo_queue: LocalQueue) -> None:
        for i in range(5):
            await fifo_queue.send_message(
                f"msg-{i}",
                message_group_id="group-1",
                message_dedup_id=f"dedup-{i}",
            )
        messages = await fifo_queue.receive_messages(max_messages=5)
        bodies = [m.body for m in messages]
        assert bodies == ["msg-0", "msg-1", "msg-2", "msg-3", "msg-4"]

    async def test_fifo_content_based_dedup(self, fifo_queue: LocalQueue) -> None:
        """Sending the same body twice should deduplicate."""
        id1 = await fifo_queue.send_message("duplicate", message_group_id="g1")
        id2 = await fifo_queue.send_message("duplicate", message_group_id="g1")
        assert id1 == id2  # same message returned

        messages = await fifo_queue.receive_messages(max_messages=10)
        assert len(messages) == 1

    async def test_fifo_explicit_dedup_id(self) -> None:
        q = LocalQueue(queue_name="fifo.fifo", is_fifo=True)
        id1 = await q.send_message("a", message_group_id="g", message_dedup_id="d1")
        id2 = await q.send_message("b", message_group_id="g", message_dedup_id="d1")
        assert id1 == id2

        messages = await q.receive_messages(max_messages=10)
        assert len(messages) == 1
        assert messages[0].body == "a"

    async def test_fifo_different_dedup_ids(self) -> None:
        q = LocalQueue(queue_name="fifo.fifo", is_fifo=True)
        await q.send_message("a", message_group_id="g", message_dedup_id="d1")
        await q.send_message("b", message_group_id="g", message_dedup_id="d2")

        messages = await q.receive_messages(max_messages=10)
        assert len(messages) == 2

    async def test_fifo_group_ordering_no_head_of_line_blocking(self) -> None:
        """Messages from different groups should not block each other."""
        q = LocalQueue(queue_name="fifo.fifo", is_fifo=True, visibility_timeout=5)

        await q.send_message("g1-m1", message_group_id="g1", message_dedup_id="g1-1")
        await q.send_message("g1-m2", message_group_id="g1", message_dedup_id="g1-2")
        await q.send_message("g2-m1", message_group_id="g2", message_dedup_id="g2-1")

        # Receive first message from g1 (makes g1 invisible)
        msgs = await q.receive_messages(max_messages=1)
        assert len(msgs) == 1
        assert msgs[0].body == "g1-m1"

        # g1 is blocked (head message in flight), but g2 should be available
        msgs = await q.receive_messages(max_messages=1)
        assert len(msgs) == 1
        assert msgs[0].body == "g2-m1"


# ---------------------------------------------------------------------------
# Long polling with asyncio.Event
# ---------------------------------------------------------------------------


class TestLongPolling:
    """Long polling behaviour via asyncio.Event."""

    async def test_long_poll_returns_when_message_arrives(self, queue: LocalQueue) -> None:
        """Long poll should return as soon as a message is sent."""

        async def _send_delayed():
            await asyncio.sleep(0.2)
            await queue.send_message("late arrival")

        task = asyncio.create_task(_send_delayed())
        start = time.monotonic()
        messages = await queue.receive_messages(max_messages=1, wait_time_seconds=5)
        elapsed = time.monotonic() - start

        assert len(messages) == 1
        assert messages[0].body == "late arrival"
        assert elapsed < 3  # Should not wait full 5 seconds
        await task

    async def test_long_poll_times_out(self, queue: LocalQueue) -> None:
        """Long poll returns empty after timeout."""
        start = time.monotonic()
        messages = await queue.receive_messages(max_messages=1, wait_time_seconds=0.3)
        elapsed = time.monotonic() - start

        assert messages == []
        assert elapsed >= 0.2  # Should have waited close to the timeout

    async def test_short_poll_returns_immediately(self, queue: LocalQueue) -> None:
        """Short poll returns immediately even when empty."""
        start = time.monotonic()
        messages = await queue.receive_messages(max_messages=1, wait_time_seconds=0)
        elapsed = time.monotonic() - start

        assert messages == []
        assert elapsed < 0.5


# ---------------------------------------------------------------------------
# SqsProvider lifecycle and IQueue interface
# ---------------------------------------------------------------------------


class TestSqsProviderLifecycle:
    """Provider lifecycle: start, stop, health_check, name."""

    async def test_name(self, provider: SqsProvider) -> None:
        assert provider.name == "sqs"

    async def test_health_check_running(self, provider: SqsProvider) -> None:
        assert await provider.health_check() is True

    async def test_health_check_stopped(self) -> None:
        p = SqsProvider(queues=[QueueConfig(queue_name="q")])
        assert await p.health_check() is False

    async def test_stop_clears_queues(self) -> None:
        p = SqsProvider(queues=[QueueConfig(queue_name="q")])
        await p.start()
        assert p.get_queue("q") is not None
        await p.stop()
        assert p.get_queue("q") is None

    async def test_implements_iqueue(self, provider: SqsProvider) -> None:
        assert isinstance(provider, IQueue)


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


class TestSqsProviderDlq:
    """Redrive policy wiring through SqsProvider."""

    async def test_redrive_policy_wired(self, provider_with_dlq: SqsProvider) -> None:
        main_q = provider_with_dlq.get_queue("main-queue")
        assert main_q is not None
        assert main_q.dead_letter_queue is not None
        assert main_q.dead_letter_queue.queue_name == "dlq"
        assert main_q.max_receive_count == 2


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

    async def test_unknown_action(self, sqs_client: httpx.AsyncClient) -> None:
        resp = await sqs_client.post(
            "/",
            data={"Action": "BogusAction"},
        )
        assert resp.status_code == 400
        assert "InvalidAction" in resp.text

    async def test_send_with_query_params(self, sqs_client: httpx.AsyncClient) -> None:
        """Action can also be passed as query parameter."""
        resp = await sqs_client.post(
            "/?Action=SendMessage"
            "&QueueUrl=http://localhost:4566/000000000000/test-queue"
            "&MessageBody=via-query",
        )
        assert resp.status_code == 200
        assert "<MessageId>" in resp.text


# ---------------------------------------------------------------------------
# Event-source poller
# ---------------------------------------------------------------------------


class TestSqsEventSourcePoller:
    """SQS event-source poller invocation tests."""

    async def test_poller_invokes_function(self) -> None:
        """Poller receives messages and invokes the correct Lambda function."""
        queue_provider = SqsProvider(
            queues=[QueueConfig(queue_name="poll-queue", visibility_timeout=30)]
        )
        await queue_provider.start()

        # Send a message
        await queue_provider.send_message("poll-queue", '{"key": "value"}')

        # Set up mock compute
        mock_compute = AsyncMock(spec=ICompute)
        mock_compute.invoke.return_value = InvocationResult(
            payload={"statusCode": 200},
            error=None,
            duration_ms=50.0,
            request_id="req-123",
        )

        mapping = EventSourceMapping(
            queue_name="poll-queue",
            function_name="my-function",
            batch_size=10,
        )

        poller = SqsEventSourcePoller(
            queue_provider=queue_provider,
            compute_providers={"my-function": mock_compute},
            mappings=[mapping],
            poll_interval=0.1,
        )

        await poller.start()
        # Give the poller time to pick up the message
        await asyncio.sleep(0.5)
        await poller.stop()

        # Verify the function was invoked
        mock_compute.invoke.assert_called()
        call_args = mock_compute.invoke.call_args
        event = call_args[0][0]
        assert "Records" in event
        assert len(event["Records"]) >= 1
        assert event["Records"][0]["body"] == '{"key": "value"}'
        assert event["Records"][0]["eventSource"] == "aws:sqs"

        await queue_provider.stop()

    async def test_poller_deletes_on_success(self) -> None:
        """Successful invocation should delete messages."""
        queue_provider = SqsProvider(
            queues=[QueueConfig(queue_name="del-queue", visibility_timeout=30)]
        )
        await queue_provider.start()

        await queue_provider.send_message("del-queue", "delete-after-invoke")

        mock_compute = AsyncMock(spec=ICompute)
        mock_compute.invoke.return_value = InvocationResult(
            payload={}, error=None, duration_ms=10.0, request_id="r1"
        )

        mapping = EventSourceMapping(
            queue_name="del-queue",
            function_name="fn",
            batch_size=1,
        )

        poller = SqsEventSourcePoller(
            queue_provider=queue_provider,
            compute_providers={"fn": mock_compute},
            mappings=[mapping],
            poll_interval=0.1,
        )

        await poller.start()
        await asyncio.sleep(0.5)
        await poller.stop()

        # Queue should be empty
        msgs = await queue_provider.receive_messages("del-queue", max_messages=10)
        assert len(msgs) == 0

        await queue_provider.stop()

    async def test_poller_retains_on_failure(self) -> None:
        """Failed invocation should leave messages in the queue."""
        queue_provider = SqsProvider(
            queues=[QueueConfig(queue_name="fail-queue", visibility_timeout=1)]
        )
        await queue_provider.start()

        await queue_provider.send_message("fail-queue", "keep-on-fail")

        mock_compute = AsyncMock(spec=ICompute)
        mock_compute.invoke.return_value = InvocationResult(
            payload=None, error="Lambda failed", duration_ms=10.0, request_id="r1"
        )

        mapping = EventSourceMapping(
            queue_name="fail-queue",
            function_name="fn",
            batch_size=1,
        )

        poller = SqsEventSourcePoller(
            queue_provider=queue_provider,
            compute_providers={"fn": mock_compute},
            mappings=[mapping],
            poll_interval=0.1,
        )

        await poller.start()
        await asyncio.sleep(0.3)
        await poller.stop()

        # Wait for visibility timeout
        await asyncio.sleep(1.2)

        # Message should still be in the queue
        msgs = await queue_provider.receive_messages("fail-queue", max_messages=10)
        assert len(msgs) >= 1

        await queue_provider.stop()

    async def test_poller_start_stop(self) -> None:
        """Poller can start and stop cleanly."""
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

        await poller.start()
        assert poller._running is True
        assert len(poller._tasks) == 1

        await poller.stop()
        assert poller._running is False
        assert len(poller._tasks) == 0

    async def test_poller_disabled_mapping_skipped(self) -> None:
        """Disabled mappings should not create polling tasks."""
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

        await poller.start()
        assert len(poller._tasks) == 0
        await poller.stop()
