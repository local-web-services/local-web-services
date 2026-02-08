"""Tests for ldk.validation.event_shape_validator."""

from __future__ import annotations

from ldk.validation.engine import ValidationContext, ValidationLevel
from ldk.validation.event_shape_validator import EventShapeValidator

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


class TestIssueLevels:
    def test_missing_field_is_warn(self) -> None:
        event = _valid_api_gateway_event()
        del event["httpMethod"]
        ctx = _make_context("api_gateway", event)
        issues = EventShapeValidator().validate(ctx)
        assert all(i.level == ValidationLevel.WARN for i in issues)

    def test_wrong_type_is_warn(self) -> None:
        event = _valid_api_gateway_event()
        event["headers"] = 42
        ctx = _make_context("api_gateway", event)
        issues = EventShapeValidator().validate(ctx)
        assert all(i.level == ValidationLevel.WARN for i in issues)
