"""Integration test for API Gateway V2 DeleteApi."""

from __future__ import annotations

import httpx


class TestV2DeleteApi:
    async def test_v2_delete_api(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 204
        create_resp = await client.post(
            "/v2/apis",
            json={"Name": "int-v2-delete-api", "ProtocolType": "HTTP"},
        )
        api_id = create_resp.json()["apiId"]

        # Act
        response = await client.delete(f"/v2/apis/{api_id}")

        # Assert
        assert response.status_code == expected_status_code

        # Verify deleted
        get_resp = await client.get(f"/v2/apis/{api_id}")
        expected_get_status = 404
        assert get_resp.status_code == expected_get_status
