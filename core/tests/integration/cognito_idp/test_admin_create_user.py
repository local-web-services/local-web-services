"""Integration test for Cognito AdminCreateUser."""

from __future__ import annotations

import httpx


class TestAdminCreateUser:
    async def test_admin_create_user(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.AdminCreateUser",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={"UserPoolId": "us-east-1_TestPool", "Username": "admin-test-user"},
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
