"""Integration test for Secrets Manager DescribeSecret."""

from __future__ import annotations

import httpx


class TestDescribeSecret:
    async def test_describe_secret(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_name = "app/my-secret"
        expected_description = "A test secret"

        await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.CreateSecret"},
            json={
                "Name": expected_name,
                "Description": expected_description,
                "SecretString": "value",
            },
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.DescribeSecret"},
            json={"SecretId": expected_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["Name"] == expected_name
        assert body["Description"] == expected_description
        assert "ARN" in body
        assert "CreatedDate" in body

    async def test_describe_secret_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "ResourceNotFoundException"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "secretsmanager.DescribeSecret"},
            json={"SecretId": "nonexistent"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["__type"] == expected_error_type
