"""Tests for ldk.validation.event_shape_validator."""

from __future__ import annotations

from lws.validation.engine import ValidationContext
from lws.validation.event_shape_validator import EventShapeValidator

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_context(
    trigger_type: str,
    event: dict,
    handler_id: str = "handler1",
) -> ValidationContext:
    return ValidationContext(
        handler_id=handler_id,
        resource_id=handler_id,
        operation="invoke",
        data={"trigger_type": trigger_type, "event": event},
    )


def _valid_api_gateway_event() -> dict:
    return {
        "httpMethod": "GET",
        "path": "/users/1",
        "headers": {"Content-Type": "application/json"},
        "queryStringParameters": None,
        "body": None,
        "requestContext": {"accountId": "123"},
    }


def _valid_sqs_event() -> dict:
    return {
        "Records": [
            {
                "messageId": "msg-1",
                "body": '{"key": "value"}',
                "eventSource": "aws:sqs",
            }
        ]
    }


def _valid_s3_event() -> dict:
    return {
        "Records": [
            {
                "eventSource": "aws:s3",
                "eventName": "ObjectCreated:Put",
                "s3": {"bucket": {"name": "my-bucket"}, "object": {"key": "my-key"}},
            }
        ]
    }


def _valid_sns_event() -> dict:
    return {
        "Records": [
            {
                "EventSource": "aws:sns",
                "Sns": {"Message": "hello"},
            }
        ]
    }


def _valid_eventbridge_event() -> dict:
    return {
        "source": "my.source",
        "detail-type": "MyEvent",
        "detail": {"key": "value"},
    }


# ---------------------------------------------------------------------------
# API Gateway event validation
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# SQS event validation
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# S3 event validation
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# SNS event validation
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# EventBridge event validation
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Unknown trigger type
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Issue levels
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Validator name
# ---------------------------------------------------------------------------


class TestSqsEvent:
    def test_valid_event(self) -> None:
        # Arrange
        ctx = _make_context("sqs", _valid_sqs_event())

        # Act
        issues = EventShapeValidator().validate(ctx)

        # Assert
        assert issues == []

    def test_missing_records(self) -> None:
        # Arrange
        ctx = _make_context("sqs", {})

        # Act
        issues = EventShapeValidator().validate(ctx)

        # Assert
        assert len(issues) >= 1
        assert any("Records" in i.message for i in issues)

    def test_record_missing_message_id(self) -> None:
        # Arrange
        expected_issue_count = 1
        event = {"Records": [{"body": "hello", "eventSource": "aws:sqs"}]}
        ctx = _make_context("sqs", event)

        # Act
        issues = EventShapeValidator().validate(ctx)

        # Assert
        assert len(issues) == expected_issue_count
        assert "messageId" in issues[0].message

    def test_record_wrong_type_body(self) -> None:
        # Arrange
        expected_issue_count = 1
        event = {
            "Records": [
                {
                    "messageId": "msg-1",
                    "body": 123,
                    "eventSource": "aws:sqs",
                }
            ]
        }
        ctx = _make_context("sqs", event)

        # Act
        issues = EventShapeValidator().validate(ctx)

        # Assert
        assert len(issues) == expected_issue_count
        assert "body" in issues[0].message
