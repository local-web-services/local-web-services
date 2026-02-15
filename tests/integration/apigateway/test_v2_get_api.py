"""Integration test for API Gateway V2 GetApi."""

from __future__ import annotations

import httpx


class TestV2GetApi:
    async def test_v2_get_api(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post(
            "/v2/apis",
            json={"Name": "int-v2-get-api", "ProtocolType": "HTTP"},
        )
        api_id = create_resp.json()["apiId"]

        # Act
        response = await client.get(f"/v2/apis/{api_id}")

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_name = "int-v2-get-api"
        actual_name = body["name"]
        assert actual_name == expected_name

    async def test_v2_get_api_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 404

        # Act
        response = await client.get("/v2/apis/nonexistent")

        # Assert
        assert response.status_code == expected_status_code
