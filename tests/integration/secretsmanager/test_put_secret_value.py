"""Integration test for Secrets Manager PutSecretValue."""

from __future__ import annotations

import httpx


class TestPutSecretValue:
    async def test_put_secret_value(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_name = "app/my-secret"
        expected_new_value = "updated-value"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": expected_name, "SecretString": "original-value"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.PutSecretValue"},
            json={"SecretId": expected_name, "SecretString": expected_new_value},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["Name"] == expected_name
        assert "VersionId" in body

        # Verify the value was updated
        get_response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.GetSecretValue"},
            json={"SecretId": expected_name},
        )
        assert get_response.json()["SecretString"] == expected_new_value

    async def test_put_secret_value_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "ResourceNotFoundException"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.PutSecretValue"},
            json={"SecretId": "nonexistent", "SecretString": "value"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["__type"] == expected_error_type
