"""Integration test for Cognito ConfirmSignUp."""

from __future__ import annotations

import httpx


class TestConfirmSignUp:
    async def test_confirm_sign_up(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_username = "confirm-user"
        expected_password = "Password1!"
        expected_client_id = "test-client"

        await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.SignUp",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "ClientId": expected_client_id,
                "Username": expected_username,
                "Password": expected_password,
            },
        )

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.ConfirmSignUp",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "ClientId": expected_client_id,
                "Username": expected_username,
                "ConfirmationCode": "123456",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        assert body == {}
