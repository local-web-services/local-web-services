"""Tests for the EventBridge provider."""

from __future__ import annotations

import asyncio
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


class TestInternalPublish:
    """Test internal event publishing for cross-service routing."""

    @pytest.mark.asyncio
    async def test_publish_internal_returns_event_id(self) -> None:
        provider = await _started_provider(rules=[])
        event_id = await provider.publish_internal(
            source="aws.s3",
            detail_type="Object Created",
            detail={"bucket": "my-bucket", "key": "test.txt"},
        )
        assert event_id  # non-empty string

    @pytest.mark.asyncio
    async def test_publish_internal_routes_to_rule(self) -> None:
        rule = RuleConfig(
            rule_name="s3-rule",
            event_bus_name="default",
            event_pattern={
                "source": ["aws.s3"],
                "detail-type": ["Object Created"],
            },
            targets=[
                RuleTarget(
                    target_id="s3-target",
                    arn="arn:aws:lambda:us-east-1:000000000000:function:s3-handler",
                ),
            ],
        )
        provider = await _started_provider(rules=[rule])
        mock_compute = _make_compute_mock(payload={"ok": True})
        provider.set_compute_providers({"s3-handler": mock_compute})

        await provider.publish_internal(
            source="aws.s3",
            detail_type="Object Created",
            detail={"bucket": "my-bucket", "key": "test.txt"},
        )
        await asyncio.sleep(0.05)

        mock_compute.invoke.assert_called_once()
        event = mock_compute.invoke.call_args[0][0]
        assert event["source"] == "aws.s3"
        assert event["detail"]["bucket"] == "my-bucket"
