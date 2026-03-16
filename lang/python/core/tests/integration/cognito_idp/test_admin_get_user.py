"""Integration test for Cognito AdminGetUser."""

from __future__ import annotations

import httpx


class TestAdminGetUser:
    async def test_admin_get_user(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        username = "admin-get-user"
        password = "Password1!"
        client_id = "test-client"

        await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.SignUp",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "ClientId": client_id,
                "Username": username,
                "Password": password,
            },
        )

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.AdminGetUser",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={"UserPoolId": "us-east-1_TestPool", "Username": username},
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
