"""Integration test for Cognito ConfirmForgotPassword."""

from __future__ import annotations

import httpx


class TestConfirmForgotPassword:
    async def test_confirm_forgot_password_bad_code(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        client_id = "test-client"
        username = "confirm-forgot-user"
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
                "X-Amz-Target": "AWSCognitoIdentityProviderService.ConfirmForgotPassword",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "ClientId": client_id,
                "Username": username,
                "ConfirmationCode": "000000",
                "Password": "NewPassword1!",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
