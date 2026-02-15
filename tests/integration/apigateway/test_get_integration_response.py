"""Integration test for API Gateway GetIntegrationResponse."""

from __future__ import annotations

import httpx


class TestGetIntegrationResponse:
    async def test_get_integration_response(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post("/restapis", json={"name": "int-get-int-resp"})
        api_body = create_resp.json()
        api_id = api_body["id"]
        root_resource_id = api_body["rootResourceId"]
        resource_resp = await client.post(
            f"/restapis/{api_id}/resources/{root_resource_id}",
            json={"pathPart": "getresp"},
        )
        resource_id = resource_resp.json()["id"]
        await client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/GET",
            json={"authorizationType": "NONE"},
        )
        await client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/GET/integration",
            json={"type": "MOCK"},
        )
        await client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/GET" "/integration/responses/200",
            json={"statusCode": "200"},
        )

        # Act
        response = await client.get(
            f"/restapis/{api_id}/resources/{resource_id}/methods/GET" "/integration/responses/200",
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_sc = "200"
        actual_sc = body["statusCode"]
        assert actual_sc == expected_sc
