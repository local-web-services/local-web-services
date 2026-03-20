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
        # Arrange
        expected_version = "0"
        expected_id = "evt-001"
        expected_source = "my.app"
        expected_account = "000000000000"
        expected_region = "us-east-1"
        expected_detail_type = "OrderPlaced"
        expected_order_id = "123"

        entry = {
            "Source": expected_source,
            "DetailType": expected_detail_type,
            "Detail": json.dumps({"orderId": expected_order_id}),
        }

        # Act
        event = _build_event_envelope(entry, expected_id)

        # Assert
        assert (
            event["version"] == expected_version
        ), f'Expected {expected_version!r} but got {event["version"]!r}'
        assert event["id"] == expected_id, f'Expected {expected_id!r} but got {event["id"]!r}'
        assert (
            event["source"] == expected_source
        ), f'Expected {expected_source!r} but got {event["source"]!r}'
        assert (
            event["account"] == expected_account
        ), f'Expected {expected_account!r} but got {event["account"]!r}'
        assert (
            event["region"] == expected_region
        ), f'Expected {expected_region!r} but got {event["region"]!r}'
        assert (
            event["detail-type"] == expected_detail_type
        ), f'Expected {expected_detail_type!r} but got {event["detail-type"]!r}'
        assert (
            event["detail"]["orderId"] == expected_order_id
        ), f'Expected {expected_order_id!r} but got {event["detail"]["orderId"]!r}'
        assert event["resources"] == [], f'Expected {[]!r} but got {event["resources"]!r}'
        assert event["time"], "Expected value to be truthy"

    def test_build_event_envelope_invalid_json_detail(self) -> None:
        entry = {
            "Source": "my.app",
            "DetailType": "Test",
            "Detail": "not-valid-json{",
        }
        event = _build_event_envelope(entry, "evt-002")
        assert event["detail"] == {}, "Expected {!r} but got {!r}".format({}, event["detail"])

    def test_build_event_envelope_dict_detail(self) -> None:
        entry = {
            "Source": "my.app",
            "DetailType": "Test",
            "Detail": {"already": "dict"},
        }
        event = _build_event_envelope(entry, "evt-003")
        assert (
            event["detail"]["already"] == "dict"
        ), f'Expected {"dict"!r} but got {event["detail"]["already"]!r}'

    def test_build_scheduled_event(self) -> None:
        # Arrange
        expected_source = "aws.events"
        expected_detail_type = "Scheduled Event"
        rule_name = "sched-rule"
        rule = RuleConfig(
            rule_name=rule_name,
            event_bus_name="default",
            schedule_expression="rate(1 minute)",
        )

        # Act
        event = _build_scheduled_event(rule)

        # Assert
        assert (
            event["source"] == expected_source
        ), f'Expected {expected_source!r} but got {event["source"]!r}'
        assert (
            event["detail-type"] == expected_detail_type
        ), f'Expected {expected_detail_type!r} but got {event["detail-type"]!r}'
        assert event["detail"] == {}, "Expected {!r} but got {!r}".format({}, event["detail"])
        assert (
            rule_name in event["resources"][0]
        ), f'Expected {rule_name!r} to be in {event["resources"][0]!r}'

    def test_extract_function_name_from_arn(self) -> None:
        arn = "arn:aws:lambda:us-east-1:000000000000:function:my-func"
        assert (
            _extract_function_name(arn) == "my-func"
        ), f'Expected {"my-func"!r} but got {_extract_function_name(arn)!r}'

    def test_extract_function_name_plain(self) -> None:
        assert (
            _extract_function_name("my-func") == "my-func"
        ), f'Expected {"my-func"!r} but got {_extract_function_name("my-func")!r}'
