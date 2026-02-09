"""Tests for the EventBridge provider."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.providers.eventbridge.provider import (
    EventBridgeProvider,
    EventBusConfig,
    RuleConfig,
    RuleTarget,
)
from lws.providers.eventbridge.scheduler import (
    parse_rate_expression,
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


class TestRateExpression:
    """Test rate expression parsing."""

    def test_rate_1_minute(self) -> None:
        assert parse_rate_expression("rate(1 minute)") == 60.0

    def test_rate_5_minutes(self) -> None:
        assert parse_rate_expression("rate(5 minutes)") == 300.0

    def test_rate_1_hour(self) -> None:
        assert parse_rate_expression("rate(1 hour)") == 3600.0

    def test_rate_12_hours(self) -> None:
        assert parse_rate_expression("rate(12 hours)") == 43200.0

    def test_rate_1_day(self) -> None:
        assert parse_rate_expression("rate(1 day)") == 86400.0

    def test_rate_7_days(self) -> None:
        assert parse_rate_expression("rate(7 days)") == 604800.0

    def test_rate_invalid_format(self) -> None:
        with pytest.raises(ValueError):
            parse_rate_expression("rate(invalid)")

    def test_rate_invalid_unit(self) -> None:
        with pytest.raises(ValueError):
            parse_rate_expression("rate(5 weeks)")

    def test_rate_missing_parens(self) -> None:
        with pytest.raises(ValueError):
            parse_rate_expression("rate 5 minutes")
