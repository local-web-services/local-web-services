"""Tests for the SNS provider (P1-17 through P1-21)."""

from __future__ import annotations

import asyncio
from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult, LambdaContext
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


class TestLambdaSubscriptionDispatch:
    """Test that Lambda subscriptions invoke the compute handler with SNS event."""

    @pytest.mark.asyncio
    async def test_lambda_dispatch_invokes_compute(self) -> None:
        # Arrange
        provider = await _started_provider()
        func_name = "my-func"
        mock_compute = _make_compute_mock(payload={"statusCode": 200})
        provider.set_compute_providers({func_name: mock_compute})
        expected_message = "test message"
        expected_subject = "Test Subject"
        expected_topic_arn = "arn:aws:sns:us-east-1:000000000000:my-topic"
        expected_event_source = "aws:sns"
        expected_record_count = 1

        await provider.subscribe(
            topic_name="my-topic",
            protocol="lambda",
            endpoint=func_name,
        )

        # Act
        await provider.publish(
            topic_name="my-topic",
            message=expected_message,
            subject=expected_subject,
        )
        await asyncio.sleep(0.05)

        # Assert
        mock_compute.invoke.assert_called_once()
        call_args = mock_compute.invoke.call_args
        actual_event = call_args[0][0]
        actual_context = call_args[0][1]

        assert "Records" in actual_event
        assert len(actual_event["Records"]) == expected_record_count
        actual_record = actual_event["Records"][0]
        assert actual_record["EventSource"] == expected_event_source
        assert actual_record["Sns"]["Message"] == expected_message
        assert actual_record["Sns"]["Subject"] == expected_subject
        assert actual_record["Sns"]["TopicArn"] == expected_topic_arn
        assert actual_record["Sns"]["MessageId"]

        assert isinstance(actual_context, LambdaContext)
        assert actual_context.function_name == func_name

    @pytest.mark.asyncio
    async def test_lambda_dispatch_missing_compute_logs_error(self) -> None:
        """When no compute provider is registered, dispatch should not raise."""
        provider = await _started_provider()
        # No compute providers set

        await provider.subscribe(
            topic_name="my-topic",
            protocol="lambda",
            endpoint="nonexistent-func",
        )
        # Should not raise
        await provider.publish(topic_name="my-topic", message="hello")
        await asyncio.sleep(0.05)
