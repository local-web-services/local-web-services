"""Integration test for API Gateway DeleteStage."""

from __future__ import annotations

import httpx


class TestDeleteStage:
    async def test_delete_stage(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 202
        create_resp = await client.post("/restapis", json={"name": "int-delete-stage"})
        api_id = create_resp.json()["id"]
        deploy_resp = await client.post(f"/restapis/{api_id}/deployments", json={})
        deployment_id = deploy_resp.json()["id"]
        await client.post(
            f"/restapis/{api_id}/stages",
            json={"stageName": "to-delete", "deploymentId": deployment_id},
        )

        # Act
        response = await client.delete(f"/restapis/{api_id}/stages/to-delete")

        # Assert
        assert response.status_code == expected_status_code
