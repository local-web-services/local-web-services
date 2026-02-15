"""Integration test for API Gateway PutMethodResponse."""

from __future__ import annotations

import httpx


class TestPutMethodResponse:
    async def test_put_method_response(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 201
        create_resp = await client.post("/restapis", json={"name": "int-put-method-resp"})
        api_body = create_resp.json()
        api_id = api_body["id"]
        root_resource_id = api_body["rootResourceId"]
        resource_resp = await client.post(
            f"/restapis/{api_id}/resources/{root_resource_id}",
            json={"pathPart": "mresp"},
        )
        resource_id = resource_resp.json()["id"]
        await client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/GET",
            json={"authorizationType": "NONE"},
        )

        # Act
        response = await client.put(
            f"/restapis/{api_id}/resources/{resource_id}/methods/GET/responses/200",
            json={"statusCode": "200"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_sc = "200"
        actual_sc = body["statusCode"]
        assert actual_sc == expected_sc
