"""Tests for EventBridge ListTargetsByRule at the provider layer."""

from __future__ import annotations

import json

import httpx
import pytest

from lws.providers.eventbridge.provider import EventBridgeProvider, RuleTarget
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


class TestListTargetsByRuleProvider:
    async def test_list_targets_empty(self, provider: EventBridgeProvider) -> None:
        await provider.put_rule("my-rule", event_pattern={"source": ["test"]})
        targets = provider.list_targets_by_rule("my-rule")
        assert targets == []

    async def test_list_targets_with_targets(self, provider: EventBridgeProvider) -> None:
        await provider.put_rule("my-rule", event_pattern={"source": ["test"]})
        await provider.put_targets(
            "my-rule",
            [
                RuleTarget(
                    target_id="t1",
                    arn="arn:aws:lambda:us-east-1:000000000000:function:func1",
                ),
                RuleTarget(
                    target_id="t2",
                    arn="arn:aws:lambda:us-east-1:000000000000:function:func2",
                    input_path="$.detail",
                ),
            ],
        )
        targets = provider.list_targets_by_rule("my-rule")
        assert len(targets) == 2
        assert targets[0]["Id"] == "t1"
        assert targets[1]["Id"] == "t2"
        assert targets[1]["InputPath"] == "$.detail"

    async def test_list_targets_nonexistent_rule_raises(
        self, provider: EventBridgeProvider
    ) -> None:
        with pytest.raises(KeyError, match="Rule not found"):
            provider.list_targets_by_rule("no-such-rule")
