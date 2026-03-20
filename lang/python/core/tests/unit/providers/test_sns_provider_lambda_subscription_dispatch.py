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


def _make_compute_fake(payload: dict | None = None, error: str | None = None) -> ICompute:
    """Return a fake ICompute whose ``invoke`` resolves to the given result."""
    fake = AsyncMock(spec=ICompute)
    fake.invoke.return_value = InvocationResult(
        payload=payload,
        error=error,
        duration_ms=1.0,
        request_id="test-request-id",
    )
    return fake


def _make_queue_fake() -> IQueue:
    """Return a fake IQueue."""
    fake = AsyncMock(spec=IQueue)
    fake.send_message.return_value = "fake-sqs-message-id"
    return fake


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
        fake_compute = _make_compute_fake(payload={"statusCode": 200})
        provider.set_compute_providers({func_name: fake_compute})
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
        fake_compute.invoke.assert_called_once()
        call_args = fake_compute.invoke.call_args
        actual_event = call_args[0][0]
        actual_context = call_args[0][1]

        assert "Records" in actual_event, f'Expected {"Records"!r} to be in {actual_event!r}'
        assert len(actual_event["Records"]) == expected_record_count, (
            f'Expected {expected_record_count!r} but got {len(actual_event["Records"])!r}'
        )
        actual_record = actual_event["Records"][0]
        assert actual_record["EventSource"] == expected_event_source, (
            f'Expected {expected_event_source!r} but got {actual_record["EventSource"]!r}'
        )
        assert actual_record["Sns"]["Message"] == expected_message, (
            f'Expected {expected_message!r} but got {actual_record["Sns"]["Message"]!r}'
        )
        assert actual_record["Sns"]["Subject"] == expected_subject, (
            f'Expected {expected_subject!r} but got {actual_record["Sns"]["Subject"]!r}'
        )
        assert actual_record["Sns"]["TopicArn"] == expected_topic_arn, (
            f'Expected {expected_topic_arn!r} but got {actual_record["Sns"]["TopicArn"]!r}'
        )
        assert actual_record["Sns"]["MessageId"], "Expected value to be truthy"

        assert isinstance(actual_context, LambdaContext), (
            f"Expected instance of {LambdaContext!r} but got {type(actual_context)!r}"
        )
        assert actual_context.function_name == func_name, (
            f"Expected {func_name!r} but got {actual_context.function_name!r}"
        )

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
