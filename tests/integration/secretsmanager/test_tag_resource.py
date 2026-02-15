"""Integration test for Secrets Manager TagResource."""

from __future__ import annotations

import httpx


class TestTagResource:
    async def test_tag_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        secret_name = "app/tag-target"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": secret_name, "SecretString": "value"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.TagResource"},
            json={
                "SecretId": secret_name,
                "Tags": [{"Key": "env", "Value": "test"}],
            },
        )

        # Assert
        assert response.status_code == expected_status_code
