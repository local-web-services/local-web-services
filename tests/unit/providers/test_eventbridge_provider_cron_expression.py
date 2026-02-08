"""Tests for the EventBridge provider."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from ldk.interfaces import ICompute, InvocationResult
from ldk.providers.eventbridge.provider import (
    EventBridgeProvider,
    EventBusConfig,
    RuleConfig,
    RuleTarget,
)
from ldk.providers.eventbridge.scheduler import (
    parse_cron_expression,
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


class TestCronExpression:
    """Test cron expression parsing."""

    def test_simple_cron(self) -> None:
        result = parse_cron_expression("cron(0 12 * * ? *)")
        assert result == "0 12 * * *"

    def test_cron_with_day_of_week(self) -> None:
        result = parse_cron_expression("cron(0 8 ? * MON-FRI *)")
        assert result == "0 8 * * MON-FRI"

    def test_cron_specific_day(self) -> None:
        result = parse_cron_expression("cron(15 10 ? * 6L *)")
        assert result == "15 10 * * 6L"

    def test_cron_invalid_fields(self) -> None:
        with pytest.raises(ValueError, match="Expected 6 fields"):
            parse_cron_expression("cron(0 12 * *)")

    def test_cron_missing_parens(self) -> None:
        with pytest.raises(ValueError):
            parse_cron_expression("cron 0 12 * * ? *")
