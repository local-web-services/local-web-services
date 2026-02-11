"""Integration test for Secrets Manager GetSecretValue."""

from __future__ import annotations

import httpx


class TestGetSecretValue:
    async def test_get_secret_value(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_name = "app/my-secret"
        expected_value = "my-secret-value"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": expected_name, "SecretString": expected_value},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.GetSecretValue"},
            json={"SecretId": expected_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["Name"] == expected_name
        assert body["SecretString"] == expected_value
        assert "VersionId" in body
        assert "AWSCURRENT" in body["VersionStages"]

    async def test_get_secret_value_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "ResourceNotFoundException"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.GetSecretValue"},
            json={"SecretId": "nonexistent-secret"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["__type"] == expected_error_type

    async def test_get_secret_value_by_version_stage(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_name = "app/versioned"
        expected_value = "original-value"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": expected_name, "SecretString": expected_value},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.GetSecretValue"},
            json={"SecretId": expected_name, "VersionStage": "AWSCURRENT"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["SecretString"] == expected_value
