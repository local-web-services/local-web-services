"""Integration test for Secrets Manager UpdateSecret."""

from __future__ import annotations

import httpx


class TestUpdateSecret:
    async def test_update_secret(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        secret_name = "app/update-target"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": secret_name, "SecretString": "old-value"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.UpdateSecret"},
            json={"SecretId": secret_name, "SecretString": "new-value"},
        )

        # Assert
        assert response.status_code == expected_status_code
