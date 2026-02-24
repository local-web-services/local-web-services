"""Tests for the SNS provider (P1-17 through P1-21)."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.interfaces.queue import IQueue
from lws.providers.sns.provider import (
    SnsProvider,
    TopicConfig,
)
from lws.providers.sns.topic import LocalTopic

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
        # Arrange
        topic_arn = "arn:aws:sns:us-east-1:000000000000:test"
        topic = LocalTopic("test", topic_arn)
        expected_arn_prefix = "arn:aws:sns:us-east-1:000000000000:test:"
        expected_subscriber_count = 1

        # Act
        actual_arn = await topic.add_subscription(protocol="lambda", endpoint="my-func")

        # Assert
        assert actual_arn.startswith(expected_arn_prefix)
        assert len(topic.subscribers) == expected_subscriber_count

    @pytest.mark.asyncio
    async def test_publish_returns_uuid_message_id(self) -> None:
        # Arrange
        topic = LocalTopic("test", "arn:aws:sns:us-east-1:000000000000:test")
        expected_uuid_parts = 5

        # Act
        actual_message_id = await topic.publish(message="hello")

        # Assert
        assert actual_message_id
        actual_parts = actual_message_id.split("-")
        assert len(actual_parts) == expected_uuid_parts

    @pytest.mark.asyncio
    async def test_multiple_subscribers(self) -> None:
        # Arrange
        topic = LocalTopic("test", "arn:aws:sns:us-east-1:000000000000:test")
        expected_subscriber_count = 2

        # Act
        actual_arn1 = await topic.add_subscription(protocol="lambda", endpoint="func-a")
        actual_arn2 = await topic.add_subscription(protocol="sqs", endpoint="queue-b")

        # Assert
        assert actual_arn1 != actual_arn2
        assert len(topic.subscribers) == expected_subscriber_count

    @pytest.mark.asyncio
    async def test_get_matching_subscribers_no_filter(self) -> None:
        # Arrange
        topic = LocalTopic("test", "arn:aws:sns:us-east-1:000000000000:test")
        expected_matching_count = 2
        await topic.add_subscription(protocol="lambda", endpoint="func-a")
        await topic.add_subscription(protocol="sqs", endpoint="queue-b")

        # Act
        actual_matching = topic.get_matching_subscribers()

        # Assert
        assert len(actual_matching) == expected_matching_count

    @pytest.mark.asyncio
    async def test_get_matching_subscribers_with_filter(self) -> None:
        # Arrange
        topic = LocalTopic("test", "arn:aws:sns:us-east-1:000000000000:test")
        expected_endpoint = "queue-b"
        expected_matching_count = 1
        await topic.add_subscription(
            protocol="lambda",
            endpoint="func-a",
            filter_policy={"color": ["red"]},
        )
        await topic.add_subscription(protocol="sqs", endpoint=expected_endpoint)
        attrs = {"color": {"DataType": "String", "StringValue": "blue"}}

        # Act
        actual_matching = topic.get_matching_subscribers(attrs)

        # Assert
        assert len(actual_matching) == expected_matching_count
        assert actual_matching[0].endpoint == expected_endpoint
