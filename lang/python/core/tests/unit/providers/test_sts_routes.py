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

        # Assert
        expected_status = 200
        expected_account = "000000000000"
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert "<GetCallerIdentityResponse" in resp.text, f'Expected {"<GetCallerIdentityResponse"!r} to be in {resp.text!r}'
        assert f"<Account>{expected_account}</Account>" in resp.text, "Expected {0!r} to be in {1!r}".format(f"<Account>{expected_account}</Account>", resp.text)
        assert "<Arn>" in resp.text, f'Expected {"<Arn>"!r} to be in {resp.text!r}'
        assert "<UserId>" in resp.text, f'Expected {"<UserId>"!r} to be in {resp.text!r}'

    @pytest.mark.asyncio
    async def test_unknown_action_returns_error(self, client) -> None:
        action_name = "GetSessionToken"
        resp = await client.post(
            "/",
            data={"Action": action_name},
        )

        # Assert
        expected_status = 400
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert "<ErrorResponse>" in resp.text, f'Expected {"<ErrorResponse>"!r} to be in {resp.text!r}'
        assert "<Code>InvalidAction</Code>" in resp.text, f'Expected {"<Code>InvalidAction</Code>"!r} to be in {resp.text!r}'
        assert "lws" in resp.text, f'Expected {"lws"!r} to be in {resp.text!r}'
        assert "STS" in resp.text, f'Expected {"STS"!r} to be in {resp.text!r}'
        assert action_name in resp.text, f"Expected {action_name!r} to be in {resp.text!r}"
