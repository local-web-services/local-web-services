"""Tests for EventBridge EnableRule/DisableRule at the provider layer."""

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


class TestEnableDisableRuleProvider:
    async def test_disable_rule(self, provider: EventBridgeProvider) -> None:
        expected_state = "DISABLED"
        await provider.put_rule("my-rule", event_pattern={"source": ["test"]})
        await provider.disable_rule("my-rule")
        result = provider.describe_rule("my-rule")
        assert result["State"] == expected_state

    async def test_enable_rule(self, provider: EventBridgeProvider) -> None:
        expected_state = "ENABLED"
        await provider.put_rule("my-rule", event_pattern={"source": ["test"]})
        await provider.disable_rule("my-rule")
        await provider.enable_rule("my-rule")
        result = provider.describe_rule("my-rule")
        assert result["State"] == expected_state

    async def test_disable_nonexistent_rule_raises(self, provider: EventBridgeProvider) -> None:
        with pytest.raises(KeyError, match="Rule not found"):
            await provider.disable_rule("no-such-rule")

    async def test_enable_nonexistent_rule_raises(self, provider: EventBridgeProvider) -> None:
        with pytest.raises(KeyError, match="Rule not found"):
            await provider.enable_rule("no-such-rule")
