"""Integration test for API Gateway CreateRestApi."""

from __future__ import annotations

import httpx


class TestCreateRestApi:
    async def test_create_rest_api(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 201
        api_name = "int-create-rest-api"

        # Act
        response = await client.post(
            "/restapis",
            json={"name": api_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "id" in body
        expected_name = api_name
        actual_name = body["name"]
        assert actual_name == expected_name
        assert "rootResourceId" in body
