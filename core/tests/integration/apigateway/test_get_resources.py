"""Integration test for API Gateway GetResources."""

from __future__ import annotations

import httpx


class TestGetResources:
    async def test_get_resources(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post("/restapis", json={"name": "int-get-resources"})
        api_id = create_resp.json()["id"]

        # Act
        response = await client.get(f"/restapis/{api_id}/resources")

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "item" in body
        assert len(body["item"]) >= 1
        expected_root_path = "/"
        actual_root_path = body["item"][0]["path"]
        assert actual_root_path == expected_root_path
