"""Tests for EventBridge EnableRule/DisableRule at the HTTP route layer."""

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


class TestEnableDisableRuleRoute:
    async def test_disable_and_enable_rule(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200
        expected_disabled_state = "DISABLED"
        expected_enabled_state = "ENABLED"
        rule_name = "test-rule"
        await _request(
            client,
            "PutRule",
            {"Name": rule_name, "EventPattern": '{"source":["test"]}'},
        )

        # Act & Assert - disable
        resp = await _request(client, "DisableRule", {"Name": rule_name})
        assert resp.status_code == expected_status_code

        resp = await _request(client, "DescribeRule", {"Name": rule_name})
        assert resp.json()["State"] == expected_disabled_state

        # Act & Assert - enable
        resp = await _request(client, "EnableRule", {"Name": rule_name})
        assert resp.status_code == expected_status_code

        resp = await _request(client, "DescribeRule", {"Name": rule_name})
        assert resp.json()["State"] == expected_enabled_state

    async def test_disable_nonexistent_rule(self, client: httpx.AsyncClient) -> None:
        expected_status_code = 400
        resp = await _request(client, "DisableRule", {"Name": "nope"})
        assert resp.status_code == expected_status_code

    async def test_enable_nonexistent_rule(self, client: httpx.AsyncClient) -> None:
        expected_status_code = 400
        resp = await _request(client, "EnableRule", {"Name": "nope"})
        assert resp.status_code == expected_status_code
