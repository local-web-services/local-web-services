"""Integration test for API Gateway V2 UpdateStage."""

from __future__ import annotations

import httpx


class TestV2UpdateStage:
    async def test_v2_update_stage(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post(
            "/v2/apis",
            json={"Name": "int-v2-update-stage", "ProtocolType": "HTTP"},
        )
        api_id = create_resp.json()["apiId"]
        await client.post(
            f"/v2/apis/{api_id}/stages",
            json={"StageName": "prod"},
        )

        # Act
        response = await client.patch(
            f"/v2/apis/{api_id}/stages/prod",
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_stage_name = "prod"
        actual_stage_name = body["stageName"]
        assert actual_stage_name == expected_stage_name
