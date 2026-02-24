"""Integration test for API Gateway V2 DeleteRoute."""

from __future__ import annotations

import httpx


class TestV2DeleteRoute:
    async def test_v2_delete_route(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 204
        create_resp = await client.post(
            "/v2/apis",
            json={"Name": "int-v2-del-route", "ProtocolType": "HTTP"},
        )
        api_id = create_resp.json()["apiId"]
        route_resp = await client.post(
            f"/v2/apis/{api_id}/routes",
            json={"RouteKey": "DELETE /temp"},
        )
        route_id = route_resp.json()["routeId"]

        # Act
        response = await client.delete(f"/v2/apis/{api_id}/routes/{route_id}")

        # Assert
        assert response.status_code == expected_status_code
