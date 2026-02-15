"""Integration test for API Gateway V2 ListRoutes."""

from __future__ import annotations

import httpx


class TestV2ListRoutes:
    async def test_v2_list_routes(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post(
            "/v2/apis",
            json={"Name": "int-v2-list-routes", "ProtocolType": "HTTP"},
        )
        api_id = create_resp.json()["apiId"]
        await client.post(
            f"/v2/apis/{api_id}/routes",
            json={"RouteKey": "GET /orders"},
        )

        # Act
        response = await client.get(f"/v2/apis/{api_id}/routes")

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "items" in body
        assert len(body["items"]) >= 1
