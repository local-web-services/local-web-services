"""Integration test for Secrets Manager CreateSecret."""

from __future__ import annotations

import httpx


class TestCreateSecret:
    async def test_create_secret_with_string(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_name = "app/my-secret"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": expected_name, "SecretString": "my-secret-value"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["Name"] == expected_name
        assert "ARN" in body
        assert "VersionId" in body

    async def test_create_secret_without_value(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_name = "app/empty-secret"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": expected_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["Name"] == expected_name
        assert "VersionId" not in body

    async def test_create_secret_duplicate(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "ResourceExistsException"
        secret_name = "app/duplicate"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": secret_name, "SecretString": "value"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": secret_name, "SecretString": "other-value"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["__type"] == expected_error_type
