"""Tests for STS stub routes."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.sts.routes import create_sts_app


class TestStsRoutes:
    """Test STS HTTP wire protocol routes."""

    @pytest.fixture
    def client(self):
        app = create_sts_app()
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://testserver")

    @pytest.mark.asyncio
    async def test_get_caller_identity(self, client) -> None:
        resp = await client.post(
            "/",
            data={"Action": "GetCallerIdentity"},
        )
        assert resp.status_code == 200
        assert "<GetCallerIdentityResponse" in resp.text
        assert "<Account>000000000000</Account>" in resp.text
        assert "<Arn>" in resp.text
        assert "<UserId>" in resp.text

    @pytest.mark.asyncio
    async def test_unknown_action_returns_error(self, client) -> None:
        resp = await client.post(
            "/",
            data={"Action": "AssumeRole"},
        )
        assert resp.status_code == 400
        assert "<ErrorResponse>" in resp.text
        assert "<Code>InvalidAction</Code>" in resp.text
        assert "lws" in resp.text
        assert "STS" in resp.text
        assert "AssumeRole" in resp.text
