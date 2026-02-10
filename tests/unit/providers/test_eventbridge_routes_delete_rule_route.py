"""Tests for EventBridge routes management operations."""

from __future__ import annotations

import json

import httpx
import pytest

from lws.providers.eventbridge.provider import EventBridgeProvider
from lws.providers.eventbridge.routes import create_eventbridge_app


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


class TestDeleteRuleRoute:
    async def test_delete_existing_rule(self, client: httpx.AsyncClient) -> None:
        await _request(
            client,
            "PutRule",
            {"Name": "test-rule", "EventPattern": '{"source":["test"]}'},
        )
        resp = await _request(client, "DeleteRule", {"Name": "test-rule"})
        assert resp.status_code == 200

    async def test_delete_nonexistent_rule(self, client: httpx.AsyncClient) -> None:
        resp = await _request(client, "DeleteRule", {"Name": "nope"})
        assert resp.status_code == 400
