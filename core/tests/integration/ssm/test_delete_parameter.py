"""Integration test for SSM DeleteParameter."""

from __future__ import annotations

import httpx


class TestDeleteParameter:
    async def test_delete_parameter(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        param_name = "/app/to-delete"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name, "Value": "value"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.DeleteParameter"},
            json={"Name": param_name},
        )

        # Assert
        assert response.status_code == expected_status_code

        # Verify parameter is gone
        get_response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.GetParameter"},
            json={"Name": param_name},
        )
        assert get_response.status_code == 400
        assert get_response.json()["__type"] == "ParameterNotFound"

    async def test_delete_parameter_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "ParameterNotFound"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.DeleteParameter"},
            json={"Name": "/nonexistent"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert body["__type"] == expected_error_type
