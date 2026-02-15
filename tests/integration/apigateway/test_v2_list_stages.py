"""Integration test for API Gateway V2 ListStages."""

from __future__ import annotations

import httpx


class TestV2ListStages:
    async def test_v2_list_stages(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post(
            "/v2/apis",
            json={"Name": "int-v2-list-stages", "ProtocolType": "HTTP"},
        )
        api_id = create_resp.json()["apiId"]
        await client.post(
            f"/v2/apis/{api_id}/stages",
            json={"StageName": "test"},
        )

        # Act
        response = await client.get(f"/v2/apis/{api_id}/stages")

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "items" in body
        assert len(body["items"]) >= 1
