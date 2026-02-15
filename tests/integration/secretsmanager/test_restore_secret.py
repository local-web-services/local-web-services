"""Integration test for Secrets Manager RestoreSecret."""

from __future__ import annotations

import httpx


class TestRestoreSecret:
    async def test_restore_secret(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        secret_name = "app/restore-target"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": secret_name, "SecretString": "value"},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.DeleteSecret"},
            json={"SecretId": secret_name},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.RestoreSecret"},
            json={"SecretId": secret_name},
        )

        # Assert
        assert response.status_code == expected_status_code
