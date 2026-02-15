"""Integration test for API Gateway V2 CreateStage."""

from __future__ import annotations

import httpx


class TestV2CreateStage:
    async def test_v2_create_stage(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 201
        create_resp = await client.post(
            "/v2/apis",
            json={"Name": "int-v2-create-stage", "ProtocolType": "HTTP"},
        )
        api_id = create_resp.json()["apiId"]

        # Act
        response = await client.post(
            f"/v2/apis/{api_id}/stages",
            json={"StageName": "dev"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_stage_name = "dev"
        actual_stage_name = body["stageName"]
        assert actual_stage_name == expected_stage_name
