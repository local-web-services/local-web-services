"""Tests for the SNS provider (P1-17 through P1-21)."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from ldk.interfaces import ICompute, InvocationResult
from ldk.interfaces.queue import IQueue
from ldk.providers.sns.provider import (
    SnsProvider,
    TopicConfig,
)
from ldk.providers.sns.topic import LocalTopic

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_compute_mock(payload: dict | None = None, error: str | None = None) -> ICompute:
    """Return a mock ICompute whose ``invoke`` resolves to the given result."""
    mock = AsyncMock(spec=ICompute)
    mock.invoke.return_value = InvocationResult(
        payload=payload,
        error=error,
        duration_ms=1.0,
        request_id="test-request-id",
    )
    return mock


def _make_queue_mock() -> IQueue:
    """Return a mock IQueue."""
    mock = AsyncMock(spec=IQueue)
    mock.send_message.return_value = "mock-sqs-message-id"
    return mock


def _topic_configs() -> list[TopicConfig]:
    return [
        TopicConfig(
            topic_name="my-topic",
            topic_arn="arn:aws:sns:us-east-1:000000000000:my-topic",
        ),
        TopicConfig(
            topic_name="other-topic",
            topic_arn="arn:aws:sns:us-east-1:000000000000:other-topic",
        ),
    ]


async def _started_provider(
    topics: list[TopicConfig] | None = None,
) -> SnsProvider:
    provider = SnsProvider(topics=topics or _topic_configs())
    await provider.start()
    return provider


def _client(app) -> httpx.AsyncClient:
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


# ===========================================================================
# LocalTopic tests
# ===========================================================================


# ===========================================================================
# SnsProvider lifecycle tests
# ===========================================================================


# ===========================================================================
# SnsProvider publish and subscribe
# ===========================================================================


# ===========================================================================
# Lambda subscription dispatch
# ===========================================================================


# ===========================================================================
# SQS subscription dispatch
# ===========================================================================


# ===========================================================================
# Fan-out to multiple subscribers
# ===========================================================================


# ===========================================================================
# Filter policy matching tests
# ===========================================================================


# ===========================================================================
# SNS event format construction
# ===========================================================================


# ===========================================================================
# SNS routes tests (wire protocol)
# ===========================================================================


class TestLocalTopicPublishAndSubscribe:
    """Test LocalTopic publish and subscribe operations."""

    @pytest.mark.asyncio
    async def test_add_subscription_returns_arn(self) -> None:
        topic = LocalTopic("test", "arn:aws:sns:us-east-1:000000000000:test")
        arn = await topic.add_subscription(protocol="lambda", endpoint="my-func")
        assert arn.startswith("arn:aws:sns:us-east-1:000000000000:test:")
        assert len(topic.subscribers) == 1

    @pytest.mark.asyncio
    async def test_publish_returns_uuid_message_id(self) -> None:
        topic = LocalTopic("test", "arn:aws:sns:us-east-1:000000000000:test")
        message_id = await topic.publish(message="hello")
        assert message_id  # non-empty string
        # UUID format: 8-4-4-4-12
        parts = message_id.split("-")
        assert len(parts) == 5

    @pytest.mark.asyncio
    async def test_multiple_subscribers(self) -> None:
        topic = LocalTopic("test", "arn:aws:sns:us-east-1:000000000000:test")
        arn1 = await topic.add_subscription(protocol="lambda", endpoint="func-a")
        arn2 = await topic.add_subscription(protocol="sqs", endpoint="queue-b")
        assert arn1 != arn2
        assert len(topic.subscribers) == 2

    @pytest.mark.asyncio
    async def test_get_matching_subscribers_no_filter(self) -> None:
        topic = LocalTopic("test", "arn:aws:sns:us-east-1:000000000000:test")
        await topic.add_subscription(protocol="lambda", endpoint="func-a")
        await topic.add_subscription(protocol="sqs", endpoint="queue-b")
        matching = topic.get_matching_subscribers()
        assert len(matching) == 2

    @pytest.mark.asyncio
    async def test_get_matching_subscribers_with_filter(self) -> None:
        topic = LocalTopic("test", "arn:aws:sns:us-east-1:000000000000:test")
        await topic.add_subscription(
            protocol="lambda",
            endpoint="func-a",
            filter_policy={"color": ["red"]},
        )
        await topic.add_subscription(protocol="sqs", endpoint="queue-b")

        attrs = {"color": {"DataType": "String", "StringValue": "blue"}}
        matching = topic.get_matching_subscribers(attrs)
        # Only the unfiltered sub matches
        assert len(matching) == 1
        assert matching[0].endpoint == "queue-b"
