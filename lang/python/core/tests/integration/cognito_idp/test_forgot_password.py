"""Integration test for Cognito ForgotPassword."""

from __future__ import annotations

import httpx


class TestForgotPassword:
    async def test_forgot_password(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        client_id = "test-client"
        username = "forgot-pw-user"
        password = "Password1!"

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
                "X-Amz-Target": "AWSCognitoIdentityProviderService.ForgotPassword",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "ClientId": client_id,
                "Username": username,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
