"""Integration test for Cognito DeleteUserPool."""

from __future__ import annotations

import httpx


class TestDeleteUserPool:
    async def test_delete_user_pool(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_pool_id = "us-east-1_TestPool"

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.DeleteUserPool",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={"UserPoolId": expected_pool_id},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        assert body == {}
