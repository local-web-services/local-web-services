"""Tests for EventBridge stub operations."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.eventbridge.provider import EventBridgeProvider
from lws.providers.eventbridge.routes import create_eventbridge_app


class TestEventBridgeStubOperations:
    """Test EventBridge returns proper errors for unknown operations."""

    @pytest.fixture
    async def provider(self):
        """Create and start an EventBridge provider."""
        p = EventBridgeProvider()
        await p.start()
        yield p
        await p.stop()

    @pytest.fixture
    def client(self, provider):
        """Create an HTTP client for the EventBridge app."""
        app = create_eventbridge_app(provider)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://testserver")

    @pytest.mark.asyncio
    async def test_unknown_operation_returns_error(self, client):
        """Test that unknown operations return HTTP 400 with UnknownOperationException."""
        resp = await client.post(
            "/",
            json={},
            headers={"x-amz-target": "AWSEvents.TestConnection"},
        )
        assert resp.status_code == 400
        body = resp.json()
        assert body["__type"] == "UnknownOperationException"
        assert "lws" in body["message"]
        assert "EventBridge" in body["message"]
        assert "TestConnection" in body["message"]
