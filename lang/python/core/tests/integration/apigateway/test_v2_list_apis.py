"""Integration test for API Gateway V2 ListApis."""

from __future__ import annotations

import httpx


class TestV2ListApis:
    async def test_v2_list_apis(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        await client.post(
            "/v2/apis",
            json={"Name": "int-v2-list-apis", "ProtocolType": "HTTP"},
        )

        # Act
        response = await client.get("/v2/apis")

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "items" in body
        assert len(body["items"]) >= 1
