"""Integration test for API Gateway UpdateStage."""

from __future__ import annotations

import httpx


class TestUpdateStage:
    async def test_update_stage(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post("/restapis", json={"name": "int-update-stage"})
        api_id = create_resp.json()["id"]
        deploy_resp = await client.post(f"/restapis/{api_id}/deployments", json={})
        deployment_id = deploy_resp.json()["id"]
        await client.post(
            f"/restapis/{api_id}/stages",
            json={"stageName": "prod", "deploymentId": deployment_id},
        )

        # Act
        response = await client.patch(
            f"/restapis/{api_id}/stages/prod",
            json={"patchOperations": []},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_stage_name = "prod"
        actual_stage_name = body["stageName"]
        assert actual_stage_name == expected_stage_name
