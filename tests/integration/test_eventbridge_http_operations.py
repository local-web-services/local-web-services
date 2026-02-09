"""Integration tests for the EventBridge HTTP wire protocol."""

from __future__ import annotations

import json

import httpx
import pytest

from lws.providers.eventbridge.provider import EventBridgeProvider, EventBusConfig
from lws.providers.eventbridge.routes import create_eventbridge_app


@pytest.fixture
async def provider():
    p = EventBridgeProvider(
        buses=[
            EventBusConfig(
                bus_name="default",
                bus_arn="arn:aws:events:us-east-1:123456789012:event-bus/default",
            )
        ]
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_eventbridge_app(provider)


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestEventBridgeHttpOperations:
    async def test_put_events(self, client: httpx.AsyncClient):
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.PutEvents"},
            json={
                "Entries": [
                    {
                        "Source": "my.app",
                        "DetailType": "OrderCreated",
                        "Detail": json.dumps({"orderId": "123"}),
                        "EventBusName": "default",
                    }
                ]
            },
        )
        assert resp.status_code == 200
        body = resp.json()
        assert body["FailedEntryCount"] == 0
        assert len(body["Entries"]) == 1
        assert body["Entries"][0]["EventId"] is not None

    async def test_put_rule(self, client: httpx.AsyncClient):
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.PutRule"},
            json={
                "Name": "test-rule",
                "EventBusName": "default",
                "EventPattern": json.dumps({"source": ["my.app"]}),
            },
        )
        assert resp.status_code == 200
        body = resp.json()
        assert "RuleArn" in body

    async def test_list_rules(self, client: httpx.AsyncClient):
        await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.PutRule"},
            json={
                "Name": "listed-rule",
                "EventBusName": "default",
                "EventPattern": json.dumps({"source": ["my.app"]}),
            },
        )

        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.ListRules"},
            json={"EventBusName": "default"},
        )
        assert resp.status_code == 200
        body = resp.json()
        rule_names = [r["Name"] for r in body["Rules"]]
        assert "listed-rule" in rule_names
