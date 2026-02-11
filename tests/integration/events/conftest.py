"""Shared fixtures for EventBridge integration tests."""

from __future__ import annotations

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
