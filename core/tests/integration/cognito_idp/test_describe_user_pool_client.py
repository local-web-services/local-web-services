"""Integration test for Cognito DescribeUserPoolClient."""

from __future__ import annotations

import httpx


class TestDescribeUserPoolClient:
    async def test_describe_user_pool_client(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.DescribeUserPoolClient",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={"UserPoolId": "us-east-1_TestPool", "ClientId": "test-client"},
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
