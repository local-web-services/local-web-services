"""Integration test for Cognito CreateUserPool."""

from __future__ import annotations

import httpx


class TestCreateUserPool:
    async def test_create_user_pool(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_pool_name = "TestPool"

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.CreateUserPool",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={"PoolName": expected_pool_name},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_pool = body["UserPool"]
        assert actual_pool["Name"] == expected_pool_name
        assert "Id" in actual_pool
        assert "Arn" in actual_pool
