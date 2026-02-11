"""Tests for EventBridge TagResource/UntagResource/ListTagsForResource at the provider layer."""

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


class TestTagResourceProvider:
    async def test_tag_and_list(self, provider: EventBridgeProvider) -> None:
        arn = "arn:aws:events:us-east-1:000000000000:rule/my-rule"
        provider.tag_resource(arn, [{"Key": "env", "Value": "prod"}])
        tags = provider.list_tags_for_resource(arn)
        assert len(tags) == 1
        assert tags[0]["Key"] == "env"
        assert tags[0]["Value"] == "prod"

    async def test_tag_overwrite(self, provider: EventBridgeProvider) -> None:
        arn = "arn:aws:events:us-east-1:000000000000:rule/my-rule"
        provider.tag_resource(arn, [{"Key": "env", "Value": "dev"}])
        provider.tag_resource(arn, [{"Key": "env", "Value": "prod"}])
        tags = provider.list_tags_for_resource(arn)
        assert len(tags) == 1
        assert tags[0]["Value"] == "prod"

    async def test_untag(self, provider: EventBridgeProvider) -> None:
        arn = "arn:aws:events:us-east-1:000000000000:rule/my-rule"
        provider.tag_resource(
            arn,
            [
                {"Key": "env", "Value": "prod"},
                {"Key": "team", "Value": "backend"},
            ],
        )
        provider.untag_resource(arn, ["env"])
        tags = provider.list_tags_for_resource(arn)
        assert len(tags) == 1
        assert tags[0]["Key"] == "team"

    async def test_list_tags_unknown_arn_returns_empty(self, provider: EventBridgeProvider) -> None:
        tags = provider.list_tags_for_resource("arn:aws:events:us-east-1:000000000000:rule/unknown")
        assert tags == []

    async def test_untag_unknown_arn_is_noop(self, provider: EventBridgeProvider) -> None:
        provider.untag_resource("arn:...", ["env"])  # should not raise
