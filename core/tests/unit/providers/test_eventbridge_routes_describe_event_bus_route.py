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


class TestDescribeEventBusRoute:
    async def test_describe_default(self, client: httpx.AsyncClient) -> None:
        resp = await _request(client, "DescribeEventBus", {"Name": "default"})
        assert resp.status_code == 200
        data = resp.json()
        assert data["Name"] == "default"

    async def test_describe_nonexistent(self, client: httpx.AsyncClient) -> None:
        resp = await _request(client, "DescribeEventBus", {"Name": "nope"})
        assert resp.status_code == 400
