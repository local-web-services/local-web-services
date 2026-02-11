"""Tests for the EventBridge provider."""

from __future__ import annotations

import json
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
from lws.providers.eventbridge.routes import create_eventbridge_app

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


class TestEventBridgeRoutes:
    """Test EventBridge HTTP wire protocol routes."""

    @pytest.mark.asyncio
    async def test_put_events_action(self) -> None:
        # Arrange
        expected_status_code = 200
        expected_failed_count = 0
        provider = await _started_provider()
        app = create_eventbridge_app(provider)

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutEvents"},
                json={
                    "Entries": [
                        {
                            "Source": "my.app",
                            "DetailType": "OrderPlaced",
                            "Detail": json.dumps({"orderId": "123"}),
                        }
                    ]
                },
            )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "Entries" in body
        assert len(body["Entries"]) == 1
        assert body["Entries"][0]["EventId"]
        assert body["FailedEntryCount"] == expected_failed_count

    @pytest.mark.asyncio
    async def test_put_rule_action(self) -> None:
        provider = await _started_provider(rules=[])
        app = create_eventbridge_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutRule"},
                json={
                    "Name": "test-rule",
                    "EventPattern": json.dumps({"source": ["test"]}),
                },
            )

        assert response.status_code == 200
        body = response.json()
        assert "RuleArn" in body
        assert "test-rule" in body["RuleArn"]

    @pytest.mark.asyncio
    async def test_put_targets_action(self) -> None:
        # Arrange
        expected_status_code = 200
        expected_failed_count = 0
        provider = await _started_provider()
        app = create_eventbridge_app(provider)

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutTargets"},
                json={
                    "Rule": "my-rule",
                    "Targets": [
                        {
                            "Id": "new-target",
                            "Arn": "arn:aws:lambda:us-east-1:000000000000:function:new-func",
                        }
                    ],
                },
            )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["FailedEntryCount"] == expected_failed_count

    @pytest.mark.asyncio
    async def test_put_targets_nonexistent_rule(self) -> None:
        # Arrange
        expected_status_code = 400
        provider = await _started_provider(rules=[])
        app = create_eventbridge_app(provider)

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutTargets"},
                json={
                    "Rule": "no-such-rule",
                    "Targets": [{"Id": "t1", "Arn": "arn:..."}],
                },
            )

        # Assert
        assert response.status_code == expected_status_code

    @pytest.mark.asyncio
    async def test_list_rules_action(self) -> None:
        provider = await _started_provider()
        app = create_eventbridge_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.ListRules"},
                json={},
            )

        assert response.status_code == 200
        body = response.json()
        assert "Rules" in body
        assert len(body["Rules"]) == 1
        assert body["Rules"][0]["Name"] == "my-rule"

    @pytest.mark.asyncio
    async def test_list_event_buses_action(self) -> None:
        provider = await _started_provider()
        app = create_eventbridge_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.ListEventBuses"},
                json={},
            )

        assert response.status_code == 200
        body = response.json()
        assert "EventBuses" in body
        names = {b["Name"] for b in body["EventBuses"]}
        assert "default" in names
        assert "custom-bus" in names

    @pytest.mark.asyncio
    async def test_unknown_target_returns_error(self) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_type = "UnknownOperationException"
        provider = await _started_provider()
        app = create_eventbridge_app(provider)

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.Bogus"},
                json={},
            )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
        assert "lws" in body["message"]
        assert "EventBridge" in body["message"]
        assert "Bogus" in body["message"]

    @pytest.mark.asyncio
    async def test_empty_body_handling(self) -> None:
        provider = await _started_provider()
        app = create_eventbridge_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.ListRules"},
                content=b"",
            )

        assert response.status_code == 200
