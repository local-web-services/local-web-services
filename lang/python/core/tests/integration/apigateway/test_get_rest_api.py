"""Integration test for API Gateway GetRestApi."""

from __future__ import annotations

import httpx


class TestGetRestApi:
    async def test_get_rest_api(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post("/restapis", json={"name": "int-get-rest-api"})
        api_id = create_resp.json()["id"]

        # Act
        response = await client.get(f"/restapis/{api_id}")

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_name = "int-get-rest-api"
        actual_name = body["name"]
        assert actual_name == expected_name

    async def test_get_rest_api_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 404

        # Act
        response = await client.get("/restapis/nonexistent")

        # Assert
        assert response.status_code == expected_status_code
