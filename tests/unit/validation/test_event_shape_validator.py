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


# ---------------------------------------------------------------------------
# SQS event validation
# ---------------------------------------------------------------------------


class TestSqsEvent:
    def test_valid_event(self) -> None:
        ctx = _make_context("sqs", _valid_sqs_event())
        issues = EventShapeValidator().validate(ctx)
        assert issues == []

    def test_missing_records(self) -> None:
        ctx = _make_context("sqs", {})
        issues = EventShapeValidator().validate(ctx)
        assert len(issues) >= 1
        assert any("Records" in i.message for i in issues)

    def test_record_missing_message_id(self) -> None:
        event = {"Records": [{"body": "hello", "eventSource": "aws:sqs"}]}
        ctx = _make_context("sqs", event)
        issues = EventShapeValidator().validate(ctx)
        assert len(issues) == 1
        assert "messageId" in issues[0].message

    def test_record_wrong_type_body(self) -> None:
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
        issues = EventShapeValidator().validate(ctx)
        assert len(issues) == 1
        assert "body" in issues[0].message


# ---------------------------------------------------------------------------
# S3 event validation
# ---------------------------------------------------------------------------


class TestS3Event:
    def test_valid_event(self) -> None:
        ctx = _make_context("s3", _valid_s3_event())
        issues = EventShapeValidator().validate(ctx)
        assert issues == []

    def test_missing_s3_key_in_record(self) -> None:
        event = {
            "Records": [
                {
                    "eventSource": "aws:s3",
                    "eventName": "ObjectCreated:Put",
                    # missing "s3"
                }
            ]
        }
        ctx = _make_context("s3", event)
        issues = EventShapeValidator().validate(ctx)
        assert len(issues) == 1
        assert "s3" in issues[0].message


# ---------------------------------------------------------------------------
# SNS event validation
# ---------------------------------------------------------------------------


class TestSnsEvent:
    def test_valid_event(self) -> None:
        ctx = _make_context("sns", _valid_sns_event())
        issues = EventShapeValidator().validate(ctx)
        assert issues == []

    def test_missing_sns_key(self) -> None:
        event = {"Records": [{"EventSource": "aws:sns"}]}
        ctx = _make_context("sns", event)
        issues = EventShapeValidator().validate(ctx)
        assert len(issues) == 1
        assert "Sns" in issues[0].message


# ---------------------------------------------------------------------------
# EventBridge event validation
# ---------------------------------------------------------------------------


class TestEventBridgeEvent:
    def test_valid_event(self) -> None:
        ctx = _make_context("eventbridge", _valid_eventbridge_event())
        issues = EventShapeValidator().validate(ctx)
        assert issues == []

    def test_missing_detail(self) -> None:
        event = {"source": "my.source", "detail-type": "MyEvent"}
        ctx = _make_context("eventbridge", event)
        issues = EventShapeValidator().validate(ctx)
        assert len(issues) == 1
        assert "detail" in issues[0].message

    def test_missing_detail_type(self) -> None:
        event = {"source": "my.source", "detail": {}}
        ctx = _make_context("eventbridge", event)
        issues = EventShapeValidator().validate(ctx)
        assert len(issues) == 1
        assert "detail-type" in issues[0].message


# ---------------------------------------------------------------------------
# Unknown trigger type
# ---------------------------------------------------------------------------


class TestUnknownTrigger:
    def test_unknown_type_returns_empty(self) -> None:
        ctx = _make_context("unknown_trigger", {"some": "data"})
        issues = EventShapeValidator().validate(ctx)
        assert issues == []

    def test_empty_trigger_returns_empty(self) -> None:
        ctx = _make_context("", {"some": "data"})
        issues = EventShapeValidator().validate(ctx)
        assert issues == []


# ---------------------------------------------------------------------------
# Issue levels
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


# ---------------------------------------------------------------------------
# Validator name
# ---------------------------------------------------------------------------


class TestValidatorName:
    def test_name_is_event_shape(self) -> None:
        assert EventShapeValidator().name == "event_shape"
