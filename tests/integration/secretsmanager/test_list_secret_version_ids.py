"""Integration test for Secrets Manager ListSecretVersionIds."""

from __future__ import annotations

import httpx


class TestListSecretVersionIds:
    async def test_list_secret_version_ids(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        secret_name = "app/version-ids-target"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": secret_name, "SecretString": "value"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.ListSecretVersionIds"},
            json={"SecretId": secret_name},
        )

        # Assert
        assert response.status_code == expected_status_code
