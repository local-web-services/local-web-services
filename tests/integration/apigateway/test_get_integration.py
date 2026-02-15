"""Integration test for API Gateway GetIntegration."""

from __future__ import annotations

import httpx


class TestGetIntegration:
    async def test_get_integration(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post("/restapis", json={"name": "int-get-integration"})
        api_body = create_resp.json()
        api_id = api_body["id"]
        root_resource_id = api_body["rootResourceId"]
        resource_resp = await client.post(
            f"/restapis/{api_id}/resources/{root_resource_id}",
            json={"pathPart": "data"},
        )
        resource_id = resource_resp.json()["id"]
        await client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/GET",
            json={"authorizationType": "NONE"},
        )
        await client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/GET/integration",
            json={"type": "AWS_PROXY"},
        )

        # Act
        response = await client.get(
            f"/restapis/{api_id}/resources/{resource_id}/methods/GET/integration",
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_type = "AWS_PROXY"
        actual_type = body["type"]
        assert actual_type == expected_type
