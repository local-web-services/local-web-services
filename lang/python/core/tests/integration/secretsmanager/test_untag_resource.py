"""Integration test for Secrets Manager UntagResource."""

from __future__ import annotations

import httpx


class TestUntagResource:
    async def test_untag_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        secret_name = "app/untag-target"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={"Name": secret_name, "SecretString": "value"},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.TagResource"},
            json={
                "SecretId": secret_name,
                "Tags": [{"Key": "env", "Value": "test"}],
            },
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.UntagResource"},
            json={
                "SecretId": secret_name,
                "TagKeys": ["env"],
            },
        )

        # Assert
        assert response.status_code == expected_status_code
