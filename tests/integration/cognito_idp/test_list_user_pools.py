"""Integration test for Cognito ListUserPools."""

from __future__ import annotations

import httpx


class TestListUserPools:
    async def test_list_user_pools(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_pool_id = "us-east-1_TestPool"

        # Act
        resp = await client.post(
            "/",
            headers={
                "X-Amz-Target": "AWSCognitoIdentityProviderService.ListUserPools",
                "Content-Type": "application/x-amz-json-1.1",
            },
            json={"MaxResults": 10},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_pool_ids = [p["Id"] for p in body["UserPools"]]
        assert expected_pool_id in actual_pool_ids
