"""Tests for EventBridge RemoveTargets at the provider layer."""

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


class TestRemoveTargetsProvider:
    async def test_remove_targets(self, provider: EventBridgeProvider) -> None:
        await provider.put_rule("my-rule", event_pattern={"source": ["test"]})
        await provider.put_targets(
            "my-rule",
            [
                RuleTarget(target_id="t1", arn="arn:..."),
                RuleTarget(target_id="t2", arn="arn:..."),
                RuleTarget(target_id="t3", arn="arn:..."),
            ],
        )
        await provider.remove_targets("my-rule", ["t1", "t3"])
        targets = provider.list_targets_by_rule("my-rule")
        assert len(targets) == 1
        assert targets[0]["Id"] == "t2"

    async def test_remove_targets_nonexistent_rule_raises(
        self, provider: EventBridgeProvider
    ) -> None:
        with pytest.raises(KeyError, match="Rule not found"):
            await provider.remove_targets("no-such-rule", ["t1"])

    async def test_remove_nonexistent_target_is_noop(self, provider: EventBridgeProvider) -> None:
        await provider.put_rule("my-rule", event_pattern={"source": ["test"]})
        await provider.put_targets(
            "my-rule",
            [RuleTarget(target_id="t1", arn="arn:...")],
        )
        await provider.remove_targets("my-rule", ["nonexistent"])
        targets = provider.list_targets_by_rule("my-rule")
        assert len(targets) == 1
