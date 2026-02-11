"""Integration test for Secrets Manager DeleteSecret."""

from __future__ import annotations

import httpx


class TestDeleteSecret:
    async def test_delete_secret(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        secret_name = "app/to-delete"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": secret_name, "SecretString": "value"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.DeleteSecret"},
            json={"SecretId": secret_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["Name"] == secret_name
        assert "DeletionDate" in body

        # Verify secret is soft-deleted (GetSecretValue should fail)
        get_response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.GetSecretValue"},
            json={"SecretId": secret_name},
        )
        assert get_response.status_code == 400
        assert get_response.json()["__type"] == "ResourceNotFoundException"

    async def test_delete_secret_force(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        secret_name = "app/force-delete"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": secret_name, "SecretString": "value"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.DeleteSecret"},
            json={"SecretId": secret_name, "ForceDeleteWithoutRecovery": True},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["Name"] == secret_name

    async def test_delete_secret_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "ResourceNotFoundException"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.DeleteSecret"},
            json={"SecretId": "nonexistent"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["__type"] == expected_error_type
