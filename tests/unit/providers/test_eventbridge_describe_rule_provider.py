"""Tests for EventBridge DescribeRule at the provider layer."""

from __future__ import annotations

import json

import httpx
import pytest

from lws.providers.eventbridge.provider import EventBridgeProvider
from lws.providers.eventbridge.routes import create_eventbridge_app


@pytest.fixture()
async def provider() -> EventBridgeProvider:
    p = EventBridgeProvider()
    await p.start()
    yield p
    await p.stop()


@pytest.fixture()
async def client() -> httpx.AsyncClient:
    provider = EventBridgeProvider()
    await provider.start()
    app = create_eventbridge_app(provider)
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    client = httpx.AsyncClient(transport=transport, base_url="http://testserver")
    yield client
    await provider.stop()


async def _request(client: httpx.AsyncClient, target: str, body: dict) -> httpx.Response:
    return await client.post(
        "/",
        content=json.dumps(body),
        headers={"X-Amz-Target": f"AWSEvents.{target}"},
    )


class TestDescribeRuleProvider:
    async def test_describe_existing_rule(self, provider: EventBridgeProvider) -> None:
        # Arrange
        rule_name = "my-rule"
        expected_state = "ENABLED"
        expected_bus_name = "default"
        expected_pattern = {"source": ["test"]}
        expected_schedule = "rate(5 minutes)"

        # Act
        await provider.put_rule(
            rule_name,
            event_pattern=expected_pattern,
            schedule_expression=expected_schedule,
        )
        result = provider.describe_rule(rule_name)

        # Assert
        assert result["Name"] == rule_name
        assert result["State"] == expected_state
        assert result["EventBusName"] == expected_bus_name
        assert rule_name in result["Arn"]
        assert json.loads(result["EventPattern"]) == expected_pattern
        assert result["ScheduleExpression"] == expected_schedule

    async def test_describe_nonexistent_rule_raises(self, provider: EventBridgeProvider) -> None:
        with pytest.raises(KeyError, match="Rule not found"):
            provider.describe_rule("no-such-rule")

    async def test_describe_rule_wrong_bus_raises(self, provider: EventBridgeProvider) -> None:
        await provider.put_rule("my-rule", event_pattern={"source": ["test"]})
        with pytest.raises(KeyError, match="Rule not found"):
            provider.describe_rule("my-rule", event_bus_name="other-bus")
