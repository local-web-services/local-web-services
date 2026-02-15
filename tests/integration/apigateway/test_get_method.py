"""Integration test for API Gateway GetMethod."""

from __future__ import annotations

import httpx


class TestGetMethod:
    async def test_get_method(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_http_method = "GET"
        create_resp = await client.post("/restapis", json={"name": "int-get-method"})
        api_body = create_resp.json()
        api_id = api_body["id"]
        root_resource_id = api_body["rootResourceId"]
        resource_resp = await client.post(
            f"/restapis/{api_id}/resources/{root_resource_id}",
            json={"pathPart": "products"},
        )
        resource_id = resource_resp.json()["id"]
        await client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/{expected_http_method}",
            json={"authorizationType": "NONE"},
        )

        # Act
        response = await client.get(
            f"/restapis/{api_id}/resources/{resource_id}/methods/{expected_http_method}",
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_http_method = body["httpMethod"]
        assert actual_http_method == expected_http_method
