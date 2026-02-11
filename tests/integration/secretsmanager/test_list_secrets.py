"""Integration test for Secrets Manager ListSecrets."""

from __future__ import annotations

import httpx


class TestListSecrets:
    async def test_list_secrets(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 2
        secret_name_1 = "app/secret1"
        secret_name_2 = "app/secret2"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": secret_name_1, "SecretString": "value1"},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": secret_name_2, "SecretString": "value2"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.ListSecrets"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["SecretList"]) == expected_count
        names = [s["Name"] for s in body["SecretList"]]
        assert secret_name_1 in names
        assert secret_name_2 in names

    async def test_list_secrets_empty(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 0

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.ListSecrets"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["SecretList"]) == expected_count

    async def test_list_secrets_excludes_deleted(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 1
        expected_name = "app/active"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": expected_name, "SecretString": "value1"},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": "app/deleted", "SecretString": "value2"},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.DeleteSecret"},
            json={"SecretId": "app/deleted"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.ListSecrets"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["SecretList"]) == expected_count
        assert body["SecretList"][0]["Name"] == expected_name
