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
        # Arrange
        expected_status_code = 400
        expected_error_type = "UnknownOperationException"

        # Act
        resp = await client.post(
            "/",
            json={},
            headers={"x-amz-target": "AWSEvents.TestConnection"},
        )

        # Assert
        assert resp.status_code == expected_status_code, f"Expected {expected_status_code!r} but got {resp.status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type, f"Expected {expected_error_type!r} but got {actual_error_type!r}"
        assert "lws" in body["message"], f'Expected {"lws"!r} to be in {body["message"]!r}'
        assert "EventBridge" in body["message"], f'Expected {"EventBridge"!r} to be in {body["message"]!r}'
        assert "TestConnection" in body["message"], f'Expected {"TestConnection"!r} to be in {body["message"]!r}'
