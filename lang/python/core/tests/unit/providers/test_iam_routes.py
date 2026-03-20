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
        role_name = "my-role"
        resp = await client.post(
            "/",
            data={
                "Action": "CreateRole",
                "RoleName": role_name,
                "AssumeRolePolicyDocument": "{}",
            },
        )

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert "<CreateRoleResponse>" in resp.text, f'Expected {"<CreateRoleResponse>"!r} to be in {resp.text!r}'
        assert f"<RoleName>{role_name}</RoleName>" in resp.text, "Expected {0!r} to be in {1!r}".format(f"<RoleName>{role_name}</RoleName>", resp.text)
        assert "<Arn>" in resp.text, f'Expected {"<Arn>"!r} to be in {resp.text!r}'

    @pytest.mark.asyncio
    async def test_get_role(self, client) -> None:
        role_name = "my-role"
        await client.post(
            "/",
            data={"Action": "CreateRole", "RoleName": role_name},
        )

        resp = await client.post(
            "/",
            data={"Action": "GetRole", "RoleName": role_name},
        )

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert "<GetRoleResponse>" in resp.text, f'Expected {"<GetRoleResponse>"!r} to be in {resp.text!r}'
        assert f"<RoleName>{role_name}</RoleName>" in resp.text, "Expected {0!r} to be in {1!r}".format(f"<RoleName>{role_name}</RoleName>", resp.text)

    @pytest.mark.asyncio
    async def test_get_role_not_found(self, client) -> None:
        resp = await client.post(
            "/",
            data={"Action": "GetRole", "RoleName": "nonexistent"},
        )

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert "NoSuchEntity" in resp.text, f'Expected {"NoSuchEntity"!r} to be in {resp.text!r}'

    @pytest.mark.asyncio
    async def test_delete_role(self, client) -> None:
        role_name = "my-role"
        await client.post(
            "/",
            data={"Action": "CreateRole", "RoleName": role_name},
        )

        resp = await client.post(
            "/",
            data={"Action": "DeleteRole", "RoleName": role_name},
        )

        # Assert
        expected_delete_status = 200
        assert resp.status_code == expected_delete_status, f"Expected {expected_delete_status!r} but got {resp.status_code!r}"
        assert "<DeleteRoleResponse>" in resp.text, f'Expected {"<DeleteRoleResponse>"!r} to be in {resp.text!r}'

        # Verify deleted
        get_resp = await client.post(
            "/",
            data={"Action": "GetRole", "RoleName": role_name},
        )
        expected_not_found_status = 404
        assert get_resp.status_code == expected_not_found_status, f"Expected {expected_not_found_status!r} but got {get_resp.status_code!r}"

    @pytest.mark.asyncio
    async def test_put_and_list_role_policies(self, client) -> None:
        role_name = "my-role"
        policy_name = "my-policy"
        await client.post(
            "/",
            data={"Action": "CreateRole", "RoleName": role_name},
        )

        await client.post(
            "/",
            data={
                "Action": "PutRolePolicy",
                "RoleName": role_name,
                "PolicyName": policy_name,
                "PolicyDocument": "{}",
            },
        )

        resp = await client.post(
            "/",
            data={"Action": "ListRolePolicies", "RoleName": role_name},
        )

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert policy_name in resp.text, f"Expected {policy_name!r} to be in {resp.text!r}"

    @pytest.mark.asyncio
    async def test_unknown_action_returns_error(self, client) -> None:
        action_name = "SomeUnknownAction"
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
        assert "IAM" in resp.text, f'Expected {"IAM"!r} to be in {resp.text!r}'
        assert action_name in resp.text, f"Expected {action_name!r} to be in {resp.text!r}"
