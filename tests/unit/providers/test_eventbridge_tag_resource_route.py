"""Tests for EventBridge TagResource/UntagResource/ListTagsForResource at the HTTP route layer."""

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


class TestTagResourceRoute:
    async def test_tag_and_list(self, client: httpx.AsyncClient) -> None:
        # Arrange
        arn = "arn:aws:events:us-east-1:000000000000:rule/test-rule"
        expected_status_code = 200
        expected_key = "env"
        expected_value = "prod"

        # Act
        resp = await _request(
            client,
            "TagResource",
            {"ResourceARN": arn, "Tags": [{"Key": expected_key, "Value": expected_value}]},
        )
        assert resp.status_code == expected_status_code

        resp = await _request(
            client,
            "ListTagsForResource",
            {"ResourceARN": arn},
        )

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        assert len(data["Tags"]) == 1
        assert data["Tags"][0]["Key"] == expected_key
        assert data["Tags"][0]["Value"] == expected_value

    async def test_untag(self, client: httpx.AsyncClient) -> None:
        arn = "arn:aws:events:us-east-1:000000000000:rule/test-rule"
        await _request(
            client,
            "TagResource",
            {
                "ResourceARN": arn,
                "Tags": [
                    {"Key": "env", "Value": "prod"},
                    {"Key": "team", "Value": "backend"},
                ],
            },
        )
        resp = await _request(
            client,
            "UntagResource",
            {"ResourceARN": arn, "TagKeys": ["env"]},
        )
        assert resp.status_code == 200

        resp = await _request(
            client,
            "ListTagsForResource",
            {"ResourceARN": arn},
        )
        tags = resp.json()["Tags"]
        assert len(tags) == 1
        assert tags[0]["Key"] == "team"

    async def test_list_tags_unknown_arn(self, client: httpx.AsyncClient) -> None:
        resp = await _request(
            client,
            "ListTagsForResource",
            {"ResourceARN": "arn:aws:events:us-east-1:000000000000:rule/unknown"},
        )
        assert resp.status_code == 200
        assert resp.json()["Tags"] == []
