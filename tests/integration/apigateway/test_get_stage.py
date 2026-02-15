"""Integration test for API Gateway GetStage."""

from __future__ import annotations

import httpx


class TestGetStage:
    async def test_get_stage(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post("/restapis", json={"name": "int-get-stage"})
        api_id = create_resp.json()["id"]
        deploy_resp = await client.post(f"/restapis/{api_id}/deployments", json={})
        deployment_id = deploy_resp.json()["id"]
        await client.post(
            f"/restapis/{api_id}/stages",
            json={"stageName": "staging", "deploymentId": deployment_id},
        )

        # Act
        response = await client.get(f"/restapis/{api_id}/stages/staging")

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_stage_name = "staging"
        actual_stage_name = body["stageName"]
        assert actual_stage_name == expected_stage_name
