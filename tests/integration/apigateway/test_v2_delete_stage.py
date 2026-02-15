"""Integration test for API Gateway V2 DeleteStage."""

from __future__ import annotations

import httpx


class TestV2DeleteStage:
    async def test_v2_delete_stage(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 204
        create_resp = await client.post(
            "/v2/apis",
            json={"Name": "int-v2-delete-stage", "ProtocolType": "HTTP"},
        )
        api_id = create_resp.json()["apiId"]
        await client.post(
            f"/v2/apis/{api_id}/stages",
            json={"StageName": "to-delete"},
        )

        # Act
        response = await client.delete(f"/v2/apis/{api_id}/stages/to-delete")

        # Assert
        assert response.status_code == expected_status_code
