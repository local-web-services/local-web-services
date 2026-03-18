"""Integration test for Cognito DescribeUserPool."""

from __future__ import annotations

import httpx


class TestDescribeUserPool:
    async def test_describe_user_pool(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_pool_id = "us-east-1_TestPool"

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.DescribeUserPool",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={"UserPoolId": expected_pool_id},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_pool = body["UserPool"]
        assert actual_pool["Id"] == expected_pool_id
        assert "Name" in actual_pool
        assert "Arn" in actual_pool
