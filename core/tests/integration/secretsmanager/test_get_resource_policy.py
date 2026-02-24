"""Integration test for Secrets Manager GetResourcePolicy."""

from __future__ import annotations

import httpx


class TestGetResourcePolicy:
    async def test_get_resource_policy(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        secret_name = "app/policy-target"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": secret_name, "SecretString": "value"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.GetResourcePolicy"},
            json={"SecretId": secret_name},
        )

        # Assert
        assert response.status_code == expected_status_code
