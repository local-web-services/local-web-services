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


class TestCreateEventBusRoute:
    async def test_create_returns_arn(self, client: httpx.AsyncClient) -> None:
        resp = await _request(client, "CreateEventBus", {"Name": "my-bus"})
        assert resp.status_code == 200
        data = resp.json()
        assert "EventBusArn" in data
        assert "my-bus" in data["EventBusArn"]

    async def test_create_missing_name(self, client: httpx.AsyncClient) -> None:
        resp = await _request(client, "CreateEventBus", {})
        assert resp.status_code == 400
