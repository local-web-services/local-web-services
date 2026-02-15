"""Integration test for API Gateway CreateStage."""

from __future__ import annotations

import httpx


class TestCreateStage:
    async def test_create_stage(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 201
        create_resp = await client.post("/restapis", json={"name": "int-create-stage"})
        api_id = create_resp.json()["id"]
        deploy_resp = await client.post(f"/restapis/{api_id}/deployments", json={})
        deployment_id = deploy_resp.json()["id"]

        # Act
        response = await client.post(
            f"/restapis/{api_id}/stages",
            json={"stageName": "dev", "deploymentId": deployment_id},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_stage_name = "dev"
        actual_stage_name = body["stageName"]
        assert actual_stage_name == expected_stage_name
