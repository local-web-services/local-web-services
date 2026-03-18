"""Integration tests for Cognito SignUp and JWKS endpoint."""

from __future__ import annotations

import httpx


class TestSignUp:
    async def test_sign_up(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_client_id = "test-client"
        expected_username = "testuser"
        expected_password = "Password1!"

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.SignUp",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={
                "ClientId": expected_client_id,
                "Username": expected_username,
                "Password": expected_password,
                "UserAttributes": [
                    {"Name": "email", "Value": "test@example.com"},
                ],
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        assert body["UserConfirmed"] is True
        assert "UserSub" in body

    async def test_jwks_endpoint(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.get("/.well-known/jwks.json")

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        assert "keys" in body
        assert len(body["keys"]) > 0
