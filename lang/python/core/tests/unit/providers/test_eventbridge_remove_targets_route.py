"""Tests for EventBridge RemoveTargets at the HTTP route layer."""

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


class TestRemoveTargetsRoute:
    async def test_remove_targets(self, client: httpx.AsyncClient) -> None:
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
                    {"Id": "t1", "Arn": "arn:..."},
                    {"Id": "t2", "Arn": "arn:..."},
                ],
            },
        )
        resp = await _request(
            client,
            "RemoveTargets",
            {"Rule": "test-rule", "Ids": ["t1"]},
        )
        assert resp.status_code == 200
        data = resp.json()
        assert data["FailedEntryCount"] == 0

        # Verify target was actually removed
        resp = await _request(client, "ListTargetsByRule", {"Rule": "test-rule"})
        targets = resp.json()["Targets"]
        assert len(targets) == 1
        assert targets[0]["Id"] == "t2"

    async def test_remove_targets_nonexistent_rule(self, client: httpx.AsyncClient) -> None:
        resp = await _request(
            client,
            "RemoveTargets",
            {"Rule": "nope", "Ids": ["t1"]},
        )
        assert resp.status_code == 400
