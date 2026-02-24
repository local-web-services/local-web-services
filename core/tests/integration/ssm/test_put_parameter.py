"""Integration test for SSM PutParameter."""

from __future__ import annotations

import httpx


class TestPutParameter:
    async def test_put_parameter(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_version = 1
        param_name = "/app/key"
        param_value = "hello"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name, "Value": param_value},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["Version"] == expected_version
        assert body["Tier"] == "Standard"

    async def test_put_parameter_overwrite(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_version = 2
        param_name = "/app/overwrite"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name, "Value": "original"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name, "Value": "updated", "Overwrite": True},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["Version"] == expected_version

    async def test_put_parameter_without_overwrite_fails(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "ParameterAlreadyExists"
        param_name = "/app/duplicate"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name, "Value": "first"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name, "Value": "second"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["__type"] == expected_error_type
