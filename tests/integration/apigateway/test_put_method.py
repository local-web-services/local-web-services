"""Integration test for API Gateway PutMethod."""

from __future__ import annotations

import httpx


class TestPutMethod:
    async def test_put_method(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 201
        expected_http_method = "GET"
        create_resp = await client.post("/restapis", json={"name": "int-put-method"})
        api_body = create_resp.json()
        api_id = api_body["id"]
        root_resource_id = api_body["rootResourceId"]
        resource_resp = await client.post(
            f"/restapis/{api_id}/resources/{root_resource_id}",
            json={"pathPart": "orders"},
        )
        resource_id = resource_resp.json()["id"]

        # Act
        response = await client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/{expected_http_method}",
            json={"authorizationType": "NONE"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_http_method = body["httpMethod"]
        assert actual_http_method == expected_http_method
