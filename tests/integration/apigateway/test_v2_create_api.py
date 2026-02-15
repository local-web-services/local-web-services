"""Integration test for API Gateway V2 CreateApi."""

from __future__ import annotations

import httpx


class TestV2CreateApi:
    async def test_v2_create_api(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 201
        api_name = "int-v2-create-api"

        # Act
        response = await client.post(
            "/v2/apis",
            json={"Name": api_name, "ProtocolType": "HTTP"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "apiId" in body
        expected_name = api_name
        actual_name = body["name"]
        assert actual_name == expected_name
