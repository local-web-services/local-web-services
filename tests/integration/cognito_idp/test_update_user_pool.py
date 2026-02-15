"""Integration test for Cognito UpdateUserPool."""

from __future__ import annotations

import httpx


class TestUpdateUserPool:
    async def test_update_user_pool(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.UpdateUserPool",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={"UserPoolId": "us-east-1_TestPool"},
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
