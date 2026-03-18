"""Integration test for API Gateway PutIntegration."""

from __future__ import annotations

import httpx


class TestPutIntegration:
    async def test_put_integration(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 201
        create_resp = await client.post("/restapis", json={"name": "int-put-integration"})
        api_body = create_resp.json()
        api_id = api_body["id"]
        root_resource_id = api_body["rootResourceId"]
        resource_resp = await client.post(
            f"/restapis/{api_id}/resources/{root_resource_id}",
            json={"pathPart": "items"},
        )
        resource_id = resource_resp.json()["id"]
        await client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/POST",
            json={"authorizationType": "NONE"},
        )

        # Act
        response = await client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/POST/integration",
            json={"type": "AWS_PROXY", "uri": "arn:aws:lambda:us-east-1:000:function:test"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_type = "AWS_PROXY"
        actual_type = body["type"]
        assert actual_type == expected_type
