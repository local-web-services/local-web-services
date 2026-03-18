"""Integration test for Cognito ListUserPoolClients."""

from __future__ import annotations

import httpx


class TestListUserPoolClients:
    async def test_list_user_pool_clients(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.ListUserPoolClients",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={"UserPoolId": "us-east-1_TestPool", "MaxResults": 60},
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
