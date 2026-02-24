"""Integration test for API Gateway V2 CreateRoute."""

from __future__ import annotations

import httpx


class TestV2CreateRoute:
    async def test_v2_create_route(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 201
        create_resp = await client.post(
            "/v2/apis",
            json={"Name": "int-v2-create-route", "ProtocolType": "HTTP"},
        )
        api_id = create_resp.json()["apiId"]

        # Act
        response = await client.post(
            f"/v2/apis/{api_id}/routes",
            json={"RouteKey": "GET /items"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "routeId" in body
        expected_route_key = "GET /items"
        actual_route_key = body["routeKey"]
        assert actual_route_key == expected_route_key
