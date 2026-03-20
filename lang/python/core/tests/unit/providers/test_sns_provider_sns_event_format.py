"""Tests for the SNS provider (P1-17 through P1-21)."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx

from lws.interfaces import ICompute, InvocationResult
from lws.interfaces.queue import IQueue
from lws.providers.sns.provider import (
    SnsProvider,
    TopicConfig,
    _build_sns_lambda_event,
    _build_sns_sqs_envelope,
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


class TestSnsEventFormat:
    """Test SNS event format builders."""

    def test_lambda_event_structure(self) -> None:
        # Arrange
        expected_topic_arn = "arn:aws:sns:us-east-1:000000000000:my-topic"
        expected_message = "hello"
        expected_message_id = "msg-123"
        expected_subject = "Test"
        expected_event_source = "aws:sns"
        expected_event_version = "1.0"
        expected_type = "Notification"

        # Act
        actual_event = _build_sns_lambda_event(
            topic_arn=expected_topic_arn,
            message=expected_message,
            message_id=expected_message_id,
            subject=expected_subject,
            message_attributes=None,
        )

        # Assert
        assert "Records" in actual_event, f'Expected {"Records"!r} to be in {actual_event!r}'
        assert len(actual_event["Records"]) == 1, f'Expected {1!r} but got {len(actual_event["Records"])!r}'

        actual_record = actual_event["Records"][0]
        assert actual_record["EventSource"] == expected_event_source, f'Expected {expected_event_source!r} but got {actual_record["EventSource"]!r}'
        assert actual_record["EventVersion"] == expected_event_version, f'Expected {expected_event_version!r} but got {actual_record["EventVersion"]!r}'
        assert "EventSubscriptionArn" in actual_record, f'Expected {"EventSubscriptionArn"!r} to be in {actual_record!r}'

        actual_sns = actual_record["Sns"]
        assert actual_sns["Type"] == expected_type, f'Expected {expected_type!r} but got {actual_sns["Type"]!r}'
        assert actual_sns["MessageId"] == expected_message_id, f'Expected {expected_message_id!r} but got {actual_sns["MessageId"]!r}'
        assert actual_sns["TopicArn"] == expected_topic_arn, f'Expected {expected_topic_arn!r} but got {actual_sns["TopicArn"]!r}'
        assert actual_sns["Subject"] == expected_subject, f'Expected {expected_subject!r} but got {actual_sns["Subject"]!r}'
        assert actual_sns["Message"] == expected_message, f'Expected {expected_message!r} but got {actual_sns["Message"]!r}'
        assert actual_sns["Timestamp"], "Expected value to be truthy"
        assert actual_sns["MessageAttributes"] == {}, "Expected {0!r} but got {1!r}".format({}, actual_sns["MessageAttributes"])

    def test_lambda_event_with_message_attributes(self) -> None:
        # Arrange
        expected_data_type = "String"
        expected_color_value = "red"
        attrs = {"color": {"DataType": expected_data_type, "StringValue": expected_color_value}}

        # Act
        actual_event = _build_sns_lambda_event(
            topic_arn="arn:aws:sns:us-east-1:000000000000:my-topic",
            message="hello",
            message_id="msg-456",
            subject=None,
            message_attributes=attrs,
        )

        # Assert
        actual_sns = actual_event["Records"][0]["Sns"]
        assert "color" in actual_sns["MessageAttributes"], f'Expected {"color"!r} to be in {actual_sns["MessageAttributes"]!r}'
        assert actual_sns["MessageAttributes"]["color"]["DataType"] == expected_data_type, f'Expected {expected_data_type!r} but got {actual_sns["MessageAttributes"]["color"]["DataType"]!r}'
        assert actual_sns["MessageAttributes"]["color"]["StringValue"] == expected_color_value, f'Expected {expected_color_value!r} but got {actual_sns["MessageAttributes"]["color"]["StringValue"]!r}'

    def test_sqs_envelope_structure(self) -> None:
        # Arrange
        expected_topic_arn = "arn:aws:sns:us-east-1:000000000000:my-topic"
        expected_message = "sqs hello"
        expected_message_id = "msg-789"
        expected_subject = "SQS Test"
        expected_type = "Notification"

        # Act
        actual_envelope = _build_sns_sqs_envelope(
            topic_arn=expected_topic_arn,
            message=expected_message,
            message_id=expected_message_id,
            subject=expected_subject,
            message_attributes=None,
        )

        # Assert
        assert actual_envelope["Type"] == expected_type, f'Expected {expected_type!r} but got {actual_envelope["Type"]!r}'
        assert actual_envelope["MessageId"] == expected_message_id, f'Expected {expected_message_id!r} but got {actual_envelope["MessageId"]!r}'
        assert actual_envelope["TopicArn"] == expected_topic_arn, f'Expected {expected_topic_arn!r} but got {actual_envelope["TopicArn"]!r}'
        assert actual_envelope["Subject"] == expected_subject, f'Expected {expected_subject!r} but got {actual_envelope["Subject"]!r}'
        assert actual_envelope["Message"] == expected_message, f'Expected {expected_message!r} but got {actual_envelope["Message"]!r}'
        assert actual_envelope["Timestamp"], "Expected value to be truthy"
        assert actual_envelope["MessageAttributes"] == {}, "Expected {0!r} but got {1!r}".format({}, actual_envelope["MessageAttributes"])
