"""Integration test for API Gateway V2 GetStage."""

from __future__ import annotations

import httpx


class TestV2GetStage:
    async def test_v2_get_stage(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post(
            "/v2/apis",
            json={"Name": "int-v2-get-stage", "ProtocolType": "HTTP"},
        )
        api_id = create_resp.json()["apiId"]
        await client.post(
            f"/v2/apis/{api_id}/stages",
            json={"StageName": "staging"},
        )

        # Act
        response = await client.get(f"/v2/apis/{api_id}/stages/staging")

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_stage_name = "staging"
        actual_stage_name = body["stageName"]
        assert actual_stage_name == expected_stage_name
