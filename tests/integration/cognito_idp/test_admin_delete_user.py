"""Integration test for Cognito AdminDeleteUser."""

from __future__ import annotations

import httpx


class TestAdminDeleteUser:
    async def test_admin_delete_user(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.AdminCreateUser",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={"UserPoolId": "us-east-1_TestPool", "Username": "admin-del-user"},
        )

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.AdminDeleteUser",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={"UserPoolId": "us-east-1_TestPool", "Username": "admin-del-user"},
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
