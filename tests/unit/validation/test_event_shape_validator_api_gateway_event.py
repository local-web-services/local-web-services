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


class TestApiGatewayEvent:
    def test_valid_event(self) -> None:
        ctx = _make_context("api_gateway", _valid_api_gateway_event())
        issues = EventShapeValidator().validate(ctx)
        assert issues == []

    def test_missing_http_method(self) -> None:
        event = _valid_api_gateway_event()
        del event["httpMethod"]
        ctx = _make_context("api_gateway", event)
        issues = EventShapeValidator().validate(ctx)
        assert len(issues) == 1
        assert "httpMethod" in issues[0].message

    def test_wrong_type_headers(self) -> None:
        event = _valid_api_gateway_event()
        event["headers"] = "not-a-dict"
        ctx = _make_context("api_gateway", event)
        issues = EventShapeValidator().validate(ctx)
        assert len(issues) == 1
        assert "headers" in issues[0].message
        assert "dict" in issues[0].message

    def test_missing_multiple_fields(self) -> None:
        event = {"body": None}
        ctx = _make_context("api_gateway", event)
        issues = EventShapeValidator().validate(ctx)
        # Should report missing httpMethod, path, headers, requestContext
        # queryStringParameters is present with None which is valid since we check 'in data'
        assert len(issues) >= 3
