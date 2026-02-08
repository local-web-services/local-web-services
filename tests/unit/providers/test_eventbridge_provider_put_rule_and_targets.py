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


class TestPutRuleAndTargets:
    """Test PutRule and PutTargets functionality."""

    @pytest.mark.asyncio
    async def test_put_rule_returns_arn(self) -> None:
        provider = await _started_provider(rules=[])
        arn = await provider.put_rule(
            rule_name="new-rule",
            event_pattern={"source": ["test"]},
        )
        assert "new-rule" in arn

    @pytest.mark.asyncio
    async def test_put_rule_adds_to_list(self) -> None:
        provider = await _started_provider(rules=[])
        await provider.put_rule(
            rule_name="new-rule",
            event_pattern={"source": ["test"]},
        )
        rules = provider.list_rules("default")
        assert len(rules) == 1
        assert rules[0].rule_name == "new-rule"

    @pytest.mark.asyncio
    async def test_put_targets_adds_to_rule(self) -> None:
        provider = await _started_provider(rules=[])
        await provider.put_rule(
            rule_name="target-test-rule",
            event_pattern={"source": ["test"]},
        )
        await provider.put_targets(
            rule_name="target-test-rule",
            targets=[
                RuleTarget(
                    target_id="t1",
                    arn="arn:aws:lambda:us-east-1:000000000000:function:my-func",
                )
            ],
        )
        rules = provider.list_rules("default")
        assert len(rules[0].targets) == 1
        assert rules[0].targets[0].target_id == "t1"

    @pytest.mark.asyncio
    async def test_put_targets_nonexistent_rule_raises(self) -> None:
        provider = await _started_provider(rules=[])
        with pytest.raises(KeyError, match="Rule not found"):
            await provider.put_targets(
                rule_name="no-such-rule",
                targets=[
                    RuleTarget(target_id="t1", arn="arn:..."),
                ],
            )
