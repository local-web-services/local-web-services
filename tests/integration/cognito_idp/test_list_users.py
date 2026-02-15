"""Integration test for Cognito ListUsers."""

from __future__ import annotations

import httpx


class TestListUsers:
    async def test_list_users(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.ListUsers",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={"UserPoolId": "us-east-1_TestPool", "Limit": 60},
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
