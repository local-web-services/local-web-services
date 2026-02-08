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


class TestEventBridgeProviderLifecycle:
    """Test EventBridgeProvider lifecycle methods."""

    def test_name(self) -> None:
        provider = EventBridgeProvider()
        assert provider.name == "eventbridge"

    @pytest.mark.asyncio
    async def test_health_check_before_start(self) -> None:
        provider = EventBridgeProvider()
        assert await provider.health_check() is False

    @pytest.mark.asyncio
    async def test_start_sets_running(self) -> None:
        provider = await _started_provider()
        assert await provider.health_check() is True

    @pytest.mark.asyncio
    async def test_stop_clears_state(self) -> None:
        provider = await _started_provider()
        await provider.stop()
        assert await provider.health_check() is False

    @pytest.mark.asyncio
    async def test_default_bus_created(self) -> None:
        provider = await _started_provider(buses=[])
        buses = provider.list_buses()
        names = {b.bus_name for b in buses}
        assert "default" in names

    @pytest.mark.asyncio
    async def test_custom_bus_created(self) -> None:
        provider = await _started_provider()
        buses = provider.list_buses()
        names = {b.bus_name for b in buses}
        assert "custom-bus" in names
        assert "default" in names

    @pytest.mark.asyncio
    async def test_rules_loaded_at_start(self) -> None:
        provider = await _started_provider()
        rules = provider.list_rules("default")
        assert len(rules) == 1
        assert rules[0].rule_name == "my-rule"
