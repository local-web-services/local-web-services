"""Tests for EventBridge ListTargetsByRule at the HTTP route layer."""

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


class TestListTargetsByRuleRoute:
    async def test_list_targets(self, client: httpx.AsyncClient) -> None:
        await _request(
            client,
            "PutRule",
            {"Name": "test-rule", "EventPattern": '{"source":["test"]}'},
        )
        await _request(
            client,
            "PutTargets",
            {
                "Rule": "test-rule",
                "Targets": [
                    {"Id": "t1", "Arn": "arn:aws:lambda:us-east-1:000000000000:function:f1"},
                ],
            },
        )
        resp = await _request(client, "ListTargetsByRule", {"Rule": "test-rule"})
        assert resp.status_code == 200
        data = resp.json()
        assert len(data["Targets"]) == 1
        assert data["Targets"][0]["Id"] == "t1"

    async def test_list_targets_nonexistent_rule(self, client: httpx.AsyncClient) -> None:
        resp = await _request(client, "ListTargetsByRule", {"Rule": "nope"})
        assert resp.status_code == 400
