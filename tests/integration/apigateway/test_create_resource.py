"""Integration test for API Gateway CreateResource."""

from __future__ import annotations

import httpx


class TestCreateResource:
    async def test_create_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 201
        create_resp = await client.post("/restapis", json={"name": "int-create-resource"})
        api_body = create_resp.json()
        api_id = api_body["id"]
        root_resource_id = api_body["rootResourceId"]

        # Act
        response = await client.post(
            f"/restapis/{api_id}/resources/{root_resource_id}",
            json={"pathPart": "items"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_path = "/items"
        actual_path = body["path"]
        assert actual_path == expected_path
        assert body["parentId"] == root_resource_id
