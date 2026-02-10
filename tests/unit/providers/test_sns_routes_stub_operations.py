"""Tests for SNS stub operations."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.sns.provider import SnsProvider
from lws.providers.sns.routes import create_sns_app


class TestSnsStubOperations:
    """Test SNS returns proper errors for unknown operations."""

    @pytest.fixture
    async def provider(self):
        """Create and start an SNS provider."""
        p = SnsProvider()
        await p.start()
        yield p
        await p.stop()

    @pytest.fixture
    def client(self, provider):
        """Create an HTTP client for the SNS app."""
        app = create_sns_app(provider)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://testserver")

    @pytest.mark.asyncio
    async def test_unknown_operation_returns_error(self, client):
        """Test that unknown operations return HTTP 400 with InvalidAction XML."""
        resp = await client.post(
            "/",
            data={"Action": "ConfirmSubscription"},
            headers={"Content-Type": "application/x-www-form-urlencoded"},
        )
        assert resp.status_code == 400
        assert "<ErrorResponse>" in resp.text
        assert "<Code>InvalidAction</Code>" in resp.text
        assert "lws" in resp.text
        assert "SNS" in resp.text
        assert "ConfirmSubscription" in resp.text
