"""Tests for IAM stub routes."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.iam.routes import create_iam_app


class TestIamRoutes:
    """Test IAM HTTP wire protocol routes."""

    @pytest.fixture
    def client(self):
        app = create_iam_app()
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://testserver")

    @pytest.mark.asyncio
    async def test_create_role(self, client) -> None:
        resp = await client.post(
            "/",
            data={
                "Action": "CreateRole",
                "RoleName": "my-role",
                "AssumeRolePolicyDocument": "{}",
            },
        )
        assert resp.status_code == 200
        assert "<CreateRoleResponse>" in resp.text
        assert "<RoleName>my-role</RoleName>" in resp.text
        assert "<Arn>" in resp.text

    @pytest.mark.asyncio
    async def test_get_role(self, client) -> None:
        await client.post(
            "/",
            data={"Action": "CreateRole", "RoleName": "my-role"},
        )

        resp = await client.post(
            "/",
            data={"Action": "GetRole", "RoleName": "my-role"},
        )
        assert resp.status_code == 200
        assert "<GetRoleResponse>" in resp.text
        assert "<RoleName>my-role</RoleName>" in resp.text

    @pytest.mark.asyncio
    async def test_get_role_not_found(self, client) -> None:
        resp = await client.post(
            "/",
            data={"Action": "GetRole", "RoleName": "nonexistent"},
        )
        assert resp.status_code == 404
        assert "NoSuchEntity" in resp.text

    @pytest.mark.asyncio
    async def test_delete_role(self, client) -> None:
        await client.post(
            "/",
            data={"Action": "CreateRole", "RoleName": "my-role"},
        )

        resp = await client.post(
            "/",
            data={"Action": "DeleteRole", "RoleName": "my-role"},
        )
        assert resp.status_code == 200
        assert "<DeleteRoleResponse>" in resp.text

        # Verify deleted
        get_resp = await client.post(
            "/",
            data={"Action": "GetRole", "RoleName": "my-role"},
        )
        assert get_resp.status_code == 404

    @pytest.mark.asyncio
    async def test_put_and_list_role_policies(self, client) -> None:
        await client.post(
            "/",
            data={"Action": "CreateRole", "RoleName": "my-role"},
        )

        await client.post(
            "/",
            data={
                "Action": "PutRolePolicy",
                "RoleName": "my-role",
                "PolicyName": "my-policy",
                "PolicyDocument": "{}",
            },
        )

        resp = await client.post(
            "/",
            data={"Action": "ListRolePolicies", "RoleName": "my-role"},
        )
        assert resp.status_code == 200
        assert "my-policy" in resp.text

    @pytest.mark.asyncio
    async def test_unknown_action_returns_error(self, client) -> None:
        resp = await client.post(
            "/",
            data={"Action": "SomeUnknownAction"},
        )
        assert resp.status_code == 400
        assert "<ErrorResponse>" in resp.text
        assert "<Code>InvalidAction</Code>" in resp.text
        assert "lws" in resp.text
        assert "IAM" in resp.text
        assert "SomeUnknownAction" in resp.text
