"""Tests for the EventBridge provider."""

from __future__ import annotations

import asyncio
import json
from unittest.mock import AsyncMock

import httpx
import pytest

from ldk.interfaces import ICompute, InvocationResult, LambdaContext
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


class TestPutEvents:
    """Test PutEvents functionality."""

    @pytest.mark.asyncio
    async def test_put_events_returns_results(self) -> None:
        provider = await _started_provider()
        results = await provider.put_events(
            [
                {
                    "Source": "my.app",
                    "DetailType": "OrderPlaced",
                    "Detail": json.dumps({"orderId": "123"}),
                },
            ]
        )
        assert len(results) == 1
        assert results[0]["EventId"]
        assert results[0]["ErrorCode"] is None

    @pytest.mark.asyncio
    async def test_put_events_routes_to_matching_rule(self) -> None:
        provider = await _started_provider()
        mock_compute = _make_compute_mock(payload={"statusCode": 200})
        provider.set_compute_providers({"order-handler": mock_compute})

        await provider.put_events(
            [
                {
                    "Source": "my.app",
                    "DetailType": "OrderPlaced",
                    "Detail": json.dumps({"orderId": "abc"}),
                },
            ]
        )

        await asyncio.sleep(0.05)

        mock_compute.invoke.assert_called_once()
        call_args = mock_compute.invoke.call_args
        event = call_args[0][0]
        context = call_args[0][1]

        assert event["source"] == "my.app"
        assert event["detail-type"] == "OrderPlaced"
        assert event["detail"]["orderId"] == "abc"
        assert event["version"] == "0"
        assert event["account"] == "000000000000"
        assert event["region"] == "us-east-1"
        assert isinstance(context, LambdaContext)

    @pytest.mark.asyncio
    async def test_put_events_no_match_no_dispatch(self) -> None:
        provider = await _started_provider()
        mock_compute = _make_compute_mock(payload={"statusCode": 200})
        provider.set_compute_providers({"order-handler": mock_compute})

        await provider.put_events(
            [
                {
                    "Source": "other.app",
                    "DetailType": "SomethingElse",
                    "Detail": "{}",
                },
            ]
        )

        await asyncio.sleep(0.05)
        mock_compute.invoke.assert_not_called()

    @pytest.mark.asyncio
    async def test_put_events_multiple_entries(self) -> None:
        provider = await _started_provider()
        results = await provider.put_events(
            [
                {
                    "Source": "my.app",
                    "DetailType": "OrderPlaced",
                    "Detail": "{}",
                },
                {
                    "Source": "my.app",
                    "DetailType": "OrderShipped",
                    "Detail": "{}",
                },
            ]
        )
        assert len(results) == 2
        assert results[0]["EventId"] != results[1]["EventId"]

    @pytest.mark.asyncio
    async def test_put_events_missing_compute_logs_error(self) -> None:
        """When no compute provider is registered, dispatch should not raise."""
        provider = await _started_provider()
        # No compute providers set

        await provider.put_events(
            [
                {
                    "Source": "my.app",
                    "DetailType": "OrderPlaced",
                    "Detail": "{}",
                },
            ]
        )
        await asyncio.sleep(0.05)
