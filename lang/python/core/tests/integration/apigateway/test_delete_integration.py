"""Integration test for API Gateway DeleteIntegration."""

from __future__ import annotations

import httpx


class TestDeleteIntegration:
    async def test_delete_integration(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 204
        create_resp = await client.post("/restapis", json={"name": "int-del-integration"})
        api_body = create_resp.json()
        api_id = api_body["id"]
        root_resource_id = api_body["rootResourceId"]
        resource_resp = await client.post(
            f"/restapis/{api_id}/resources/{root_resource_id}",
            json={"pathPart": "remove"},
        )
        resource_id = resource_resp.json()["id"]
        await client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/POST",
            json={"authorizationType": "NONE"},
        )
        await client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/POST/integration",
            json={"type": "AWS_PROXY"},
        )

        # Act
        response = await client.delete(
            f"/restapis/{api_id}/resources/{resource_id}/methods/POST/integration",
        )

        # Assert
        assert response.status_code == expected_status_code
