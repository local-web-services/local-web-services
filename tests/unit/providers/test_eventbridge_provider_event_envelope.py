"""Tests for the EventBridge provider."""

from __future__ import annotations

import json
from unittest.mock import AsyncMock

import httpx

from lws.interfaces import ICompute, InvocationResult
from lws.providers.eventbridge.provider import (
    EventBridgeProvider,
    EventBusConfig,
    RuleConfig,
    RuleTarget,
    _build_event_envelope,
    _build_scheduled_event,
    _extract_function_name,
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


def _bus_configs() -> list[EventBusConfig]:
    return [
        EventBusConfig(
            bus_name="custom-bus",
            bus_arn="arn:aws:events:us-east-1:000000000000:event-bus/custom-bus",
        ),
    ]


def _rule_configs() -> list[RuleConfig]:
    return [
        RuleConfig(
            rule_name="my-rule",
            event_bus_name="default",
            event_pattern={
                "source": ["my.app"],
                "detail-type": ["OrderPlaced"],
            },
            targets=[
                RuleTarget(
                    target_id="target-1",
                    arn="arn:aws:lambda:us-east-1:000000000000:function:order-handler",
                ),
            ],
        ),
    ]


async def _started_provider(
    buses: list[EventBusConfig] | None = None,
    rules: list[RuleConfig] | None = None,
) -> EventBridgeProvider:
    provider = EventBridgeProvider(
        buses=_bus_configs() if buses is None else buses,
        rules=_rule_configs() if rules is None else rules,
    )
    await provider.start()
    return provider


def _client(app) -> httpx.AsyncClient:
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


# ===========================================================================
# Provider lifecycle tests
# ===========================================================================


# ===========================================================================
# PutEvents tests
# ===========================================================================


# Should not raise


# ===========================================================================
# PutRule and PutTargets tests
# ===========================================================================


# ===========================================================================
# Cross-service internal publishing
# ===========================================================================


# ===========================================================================
# Event envelope tests
# ===========================================================================


# ===========================================================================
# Scheduler tests
# ===========================================================================


# ===========================================================================
# Routes tests (wire protocol)
# ===========================================================================


class TestEventEnvelope:
    """Test event envelope construction."""

    def test_build_event_envelope_structure(self) -> None:
        entry = {
            "Source": "my.app",
            "DetailType": "OrderPlaced",
            "Detail": json.dumps({"orderId": "123"}),
        }
        event = _build_event_envelope(entry, "evt-001")

        assert event["version"] == "0"
        assert event["id"] == "evt-001"
        assert event["source"] == "my.app"
        assert event["account"] == "000000000000"
        assert event["region"] == "us-east-1"
        assert event["detail-type"] == "OrderPlaced"
        assert event["detail"]["orderId"] == "123"
        assert event["resources"] == []
        assert event["time"]

    def test_build_event_envelope_invalid_json_detail(self) -> None:
        entry = {
            "Source": "my.app",
            "DetailType": "Test",
            "Detail": "not-valid-json{",
        }
        event = _build_event_envelope(entry, "evt-002")
        assert event["detail"] == {}

    def test_build_event_envelope_dict_detail(self) -> None:
        entry = {
            "Source": "my.app",
            "DetailType": "Test",
            "Detail": {"already": "dict"},
        }
        event = _build_event_envelope(entry, "evt-003")
        assert event["detail"]["already"] == "dict"

    def test_build_scheduled_event(self) -> None:
        rule = RuleConfig(
            rule_name="sched-rule",
            event_bus_name="default",
            schedule_expression="rate(1 minute)",
        )
        event = _build_scheduled_event(rule)

        assert event["source"] == "aws.events"
        assert event["detail-type"] == "Scheduled Event"
        assert event["detail"] == {}
        assert "sched-rule" in event["resources"][0]

    def test_extract_function_name_from_arn(self) -> None:
        arn = "arn:aws:lambda:us-east-1:000000000000:function:my-func"
        assert _extract_function_name(arn) == "my-func"

    def test_extract_function_name_plain(self) -> None:
        assert _extract_function_name("my-func") == "my-func"
