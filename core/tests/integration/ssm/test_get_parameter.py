"""Integration test for SSM GetParameter."""

from __future__ import annotations

import httpx


class TestGetParameter:
    async def test_get_parameter(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_name = "/app/key"
        expected_value = "hello"
        expected_type = "String"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": expected_name, "Value": expected_value},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.GetParameter"},
            json={"Name": expected_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        param = body["Parameter"]
        assert param["Name"] == expected_name
        assert param["Value"] == expected_value
        assert param["Type"] == expected_type
        assert "ARN" in param
        assert "Version" in param

    async def test_get_parameter_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "ParameterNotFound"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.GetParameter"},
            json={"Name": "/nonexistent"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["__type"] == expected_error_type

    async def test_get_secure_string_masked(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_masked_value = "***"
        param_name = "/app/secret"
        secret_value = "s3cr3t"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name, "Value": secret_value, "Type": "SecureString"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.GetParameter"},
            json={"Name": param_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["Parameter"]["Value"] == expected_masked_value

    async def test_get_secure_string_decrypted(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        param_name = "/app/secret"
        expected_value = "s3cr3t"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name, "Value": expected_value, "Type": "SecureString"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.GetParameter"},
            json={"Name": param_name, "WithDecryption": True},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["Parameter"]["Value"] == expected_value
