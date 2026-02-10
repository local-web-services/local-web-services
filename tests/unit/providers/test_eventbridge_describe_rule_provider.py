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
        await provider.put_rule(
            "my-rule",
            event_pattern={"source": ["test"]},
            schedule_expression="rate(5 minutes)",
        )
        result = provider.describe_rule("my-rule")
        assert result["Name"] == "my-rule"
        assert result["State"] == "ENABLED"
        assert result["EventBusName"] == "default"
        assert "my-rule" in result["Arn"]
        assert json.loads(result["EventPattern"]) == {"source": ["test"]}
        assert result["ScheduleExpression"] == "rate(5 minutes)"

    async def test_describe_nonexistent_rule_raises(self, provider: EventBridgeProvider) -> None:
        with pytest.raises(KeyError, match="Rule not found"):
            provider.describe_rule("no-such-rule")

    async def test_describe_rule_wrong_bus_raises(self, provider: EventBridgeProvider) -> None:
        await provider.put_rule("my-rule", event_pattern={"source": ["test"]})
        with pytest.raises(KeyError, match="Rule not found"):
            provider.describe_rule("my-rule", event_bus_name="other-bus")
