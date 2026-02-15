"""Integration test for Cognito CreateUserPoolClient."""

from __future__ import annotations

import httpx


class TestCreateUserPoolClient:
    async def test_create_user_pool_client(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.CreateUserPoolClient",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={"UserPoolId": "us-east-1_TestPool", "ClientName": "new-client"},
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
