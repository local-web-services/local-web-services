"""Integration test for API Gateway DeleteResource."""

from __future__ import annotations

import httpx


class TestDeleteResource:
    async def test_delete_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 202
        create_resp = await client.post("/restapis", json={"name": "int-delete-resource"})
        api_body = create_resp.json()
        api_id = api_body["id"]
        root_resource_id = api_body["rootResourceId"]
        resource_resp = await client.post(
            f"/restapis/{api_id}/resources/{root_resource_id}",
            json={"pathPart": "to-delete"},
        )
        resource_id = resource_resp.json()["id"]

        # Act
        response = await client.delete(f"/restapis/{api_id}/resources/{resource_id}")

        # Assert
        assert response.status_code == expected_status_code
