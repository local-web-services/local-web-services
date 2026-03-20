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
        # Arrange
        expected_status = 400

        # Act
        resp = await client.post(
            "/",
            data={"Action": "AddPermission"},
            headers={"Content-Type": "application/x-www-form-urlencoded"},
        )

        # Assert
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert "<ErrorResponse>" in resp.text, f'Expected {"<ErrorResponse>"!r} to be in {resp.text!r}'
        assert "<Code>InvalidAction</Code>" in resp.text, f'Expected {"<Code>InvalidAction</Code>"!r} to be in {resp.text!r}'
        assert "lws" in resp.text, f'Expected {"lws"!r} to be in {resp.text!r}'
        assert "SNS" in resp.text, f'Expected {"SNS"!r} to be in {resp.text!r}'
        assert "AddPermission" in resp.text, f'Expected {"AddPermission"!r} to be in {resp.text!r}'
