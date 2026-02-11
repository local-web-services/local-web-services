"""Integration test for Cognito InitiateAuth."""

from __future__ import annotations

import httpx


class TestInitiateAuth:
    async def test_initiate_auth(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        client_id = "test-client"
        username = "authuser"
        password = "Password1!"
        cognito_headers = {
            "X-Amz-Target": "AWSCognitoIdentityProviderService.SignUp",
            "Content-Type": "application/x-amz-json-1.1",
        }

        await client.post(
            "/",
            headers=cognito_headers,
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
                "X-Amz-Target": "AWSCognitoIdentityProviderService.InitiateAuth",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "AuthFlow": "USER_PASSWORD_AUTH",
                "ClientId": client_id,
                "AuthParameters": {
                    "USERNAME": username,
                    "PASSWORD": password,
                },
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_auth_result = body["AuthenticationResult"]
        assert "IdToken" in actual_auth_result
        assert "AccessToken" in actual_auth_result
        assert "RefreshToken" in actual_auth_result
