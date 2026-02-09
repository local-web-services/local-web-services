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
        provider = await _started_provider()
        mock_compute = _make_compute_mock(payload={"statusCode": 200})
        provider.set_compute_providers({"my-func": mock_compute})

        await provider.subscribe(
            topic_name="my-topic",
            protocol="lambda",
            endpoint="my-func",
        )
        await provider.publish(
            topic_name="my-topic",
            message="test message",
            subject="Test Subject",
        )

        # Allow the asyncio.create_task to execute
        await asyncio.sleep(0.05)

        mock_compute.invoke.assert_called_once()
        call_args = mock_compute.invoke.call_args
        event = call_args[0][0]
        context = call_args[0][1]

        # Verify SNS event format
        assert "Records" in event
        assert len(event["Records"]) == 1
        record = event["Records"][0]
        assert record["EventSource"] == "aws:sns"
        assert record["Sns"]["Message"] == "test message"
        assert record["Sns"]["Subject"] == "Test Subject"
        assert record["Sns"]["TopicArn"] == "arn:aws:sns:us-east-1:000000000000:my-topic"
        assert record["Sns"]["MessageId"]

        # Verify context
        assert isinstance(context, LambdaContext)
        assert context.function_name == "my-func"

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
