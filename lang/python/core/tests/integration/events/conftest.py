"""Fixtures for EventBridge integration tests."""

from __future__ import annotations

import pytest
from starlette.testclient import TestClient

from lws.providers.eventbridge.provider import EventBridgeProvider, EventBusConfig
from lws.providers.eventbridge.routes import create_eventbridge_app

# Import step packages — each __init__.py aggregates its step files.
# Wildcard into conftest namespace so pytest-bdd can discover step definitions.
from .given import *  # noqa: F401,F403
from .then import *  # noqa: F401,F403
from .when import *  # noqa: F401,F403


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
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c
