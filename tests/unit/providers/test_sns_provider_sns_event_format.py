"""Tests for the SNS provider (P1-17 through P1-21)."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx

from ldk.interfaces import ICompute, InvocationResult
from ldk.interfaces.queue import IQueue
from ldk.providers.sns.provider import (
    SnsProvider,
    TopicConfig,
    _build_sns_lambda_event,
    _build_sns_sqs_envelope,
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


class TestSnsEventFormat:
    """Test SNS event format builders."""

    def test_lambda_event_structure(self) -> None:
        event = _build_sns_lambda_event(
            topic_arn="arn:aws:sns:us-east-1:000000000000:my-topic",
            message="hello",
            message_id="msg-123",
            subject="Test",
            message_attributes=None,
        )

        assert "Records" in event
        assert len(event["Records"]) == 1

        record = event["Records"][0]
        assert record["EventSource"] == "aws:sns"
        assert record["EventVersion"] == "1.0"
        assert "EventSubscriptionArn" in record

        sns = record["Sns"]
        assert sns["Type"] == "Notification"
        assert sns["MessageId"] == "msg-123"
        assert sns["TopicArn"] == "arn:aws:sns:us-east-1:000000000000:my-topic"
        assert sns["Subject"] == "Test"
        assert sns["Message"] == "hello"
        assert sns["Timestamp"]
        assert sns["MessageAttributes"] == {}

    def test_lambda_event_with_message_attributes(self) -> None:
        attrs = {"color": {"DataType": "String", "StringValue": "red"}}
        event = _build_sns_lambda_event(
            topic_arn="arn:aws:sns:us-east-1:000000000000:my-topic",
            message="hello",
            message_id="msg-456",
            subject=None,
            message_attributes=attrs,
        )

        sns = event["Records"][0]["Sns"]
        assert "color" in sns["MessageAttributes"]
        assert sns["MessageAttributes"]["color"]["DataType"] == "String"
        assert sns["MessageAttributes"]["color"]["StringValue"] == "red"

    def test_sqs_envelope_structure(self) -> None:
        envelope = _build_sns_sqs_envelope(
            topic_arn="arn:aws:sns:us-east-1:000000000000:my-topic",
            message="sqs hello",
            message_id="msg-789",
            subject="SQS Test",
            message_attributes=None,
        )

        assert envelope["Type"] == "Notification"
        assert envelope["MessageId"] == "msg-789"
        assert envelope["TopicArn"] == "arn:aws:sns:us-east-1:000000000000:my-topic"
        assert envelope["Subject"] == "SQS Test"
        assert envelope["Message"] == "sqs hello"
        assert envelope["Timestamp"]
        assert envelope["MessageAttributes"] == {}
