"""Tests for the SNS provider (P1-17 through P1-21)."""

from __future__ import annotations

import asyncio
import json
from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.interfaces.queue import IQueue
from lws.providers.sns.provider import (
    SnsProvider,
    TopicConfig,
)

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


class TestSqsSubscriptionDispatch:
    """Test that SQS subscriptions forward messages wrapped in SNS envelope."""

    @pytest.mark.asyncio
    async def test_sqs_dispatch_sends_message(self) -> None:
        # Arrange
        provider = await _started_provider()
        mock_queue = _make_queue_mock()
        provider.set_queue_provider(mock_queue)
        expected_queue_name = "my-queue"
        expected_message = "sqs test message"
        expected_subject = "SQS Subject"
        expected_topic_arn = "arn:aws:sns:us-east-1:000000000000:my-topic"
        expected_type = "Notification"

        await provider.subscribe(
            topic_name="my-topic",
            protocol="sqs",
            endpoint="arn:aws:sqs:us-east-1:000000000000:my-queue",
        )

        # Act
        await provider.publish(
            topic_name="my-topic",
            message=expected_message,
            subject=expected_subject,
        )
        await asyncio.sleep(0.05)

        # Assert
        mock_queue.send_message.assert_called_once()
        call_kwargs = mock_queue.send_message.call_args
        actual_queue_name = call_kwargs[1]["queue_name"]
        assert actual_queue_name == expected_queue_name

        actual_body = json.loads(call_kwargs[1]["message_body"])
        assert actual_body["Type"] == expected_type
        assert actual_body["Message"] == expected_message
        assert actual_body["Subject"] == expected_subject
        assert actual_body["TopicArn"] == expected_topic_arn

    @pytest.mark.asyncio
    async def test_sqs_dispatch_no_queue_provider_logs_error(self) -> None:
        """When no queue provider is configured, dispatch should not raise."""
        provider = await _started_provider()
        # No queue provider set

        await provider.subscribe(
            topic_name="my-topic",
            protocol="sqs",
            endpoint="arn:aws:sqs:us-east-1:000000000000:my-queue",
        )
        # Should not raise
        await provider.publish(topic_name="my-topic", message="hello")
        await asyncio.sleep(0.05)
