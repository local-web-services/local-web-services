"""Integration test for API Gateway V2 GetRoute."""

from __future__ import annotations

import httpx


class TestV2GetRoute:
    async def test_v2_get_route(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post(
            "/v2/apis",
            json={"Name": "int-v2-get-route", "ProtocolType": "HTTP"},
        )
        api_id = create_resp.json()["apiId"]
        route_resp = await client.post(
            f"/v2/apis/{api_id}/routes",
            json={"RouteKey": "POST /data"},
        )
        route_id = route_resp.json()["routeId"]

        # Act
        response = await client.get(f"/v2/apis/{api_id}/routes/{route_id}")

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_route_key = "POST /data"
        actual_route_key = body["routeKey"]
        assert actual_route_key == expected_route_key
