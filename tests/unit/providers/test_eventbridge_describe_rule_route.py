"""Tests for EventBridge DescribeRule at the HTTP route layer."""

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


class TestDescribeRuleRoute:
    async def test_describe_existing_rule(self, client: httpx.AsyncClient) -> None:
        await _request(
            client,
            "PutRule",
            {"Name": "test-rule", "EventPattern": '{"source":["test"]}'},
        )
        resp = await _request(client, "DescribeRule", {"Name": "test-rule"})
        assert resp.status_code == 200
        data = resp.json()
        assert data["Name"] == "test-rule"
        assert data["State"] == "ENABLED"

    async def test_describe_nonexistent_rule(self, client: httpx.AsyncClient) -> None:
        resp = await _request(client, "DescribeRule", {"Name": "nope"})
        assert resp.status_code == 400
