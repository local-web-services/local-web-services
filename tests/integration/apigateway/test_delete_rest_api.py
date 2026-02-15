"""Integration test for API Gateway DeleteRestApi."""

from __future__ import annotations

import httpx


class TestDeleteRestApi:
    async def test_delete_rest_api(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 202
        create_resp = await client.post("/restapis", json={"name": "int-delete-rest-api"})
        api_id = create_resp.json()["id"]

        # Act
        response = await client.delete(f"/restapis/{api_id}")

        # Assert
        assert response.status_code == expected_status_code

        # Verify deleted
        get_resp = await client.get(f"/restapis/{api_id}")
        expected_get_status = 404
        assert get_resp.status_code == expected_get_status
