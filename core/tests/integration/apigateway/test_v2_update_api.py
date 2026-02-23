"""Integration test for API Gateway V2 UpdateApi."""

from __future__ import annotations

import httpx


class TestV2UpdateApi:
    async def test_v2_update_api(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post(
            "/v2/apis",
            json={"Name": "int-v2-update-api", "ProtocolType": "HTTP"},
        )
        api_id = create_resp.json()["apiId"]

        # Act
        response = await client.patch(
            f"/v2/apis/{api_id}",
            json={"Name": "int-v2-updated"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_name = "int-v2-updated"
        actual_name = body["name"]
        assert actual_name == expected_name
