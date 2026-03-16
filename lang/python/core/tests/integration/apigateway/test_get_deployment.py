"""Integration test for API Gateway GetDeployment."""

from __future__ import annotations

import httpx


class TestGetDeployment:
    async def test_get_deployment(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post("/restapis", json={"name": "int-get-deployment"})
        api_id = create_resp.json()["id"]
        deploy_resp = await client.post(f"/restapis/{api_id}/deployments", json={})
        deployment_id = deploy_resp.json()["id"]

        # Act
        response = await client.get(f"/restapis/{api_id}/deployments/{deployment_id}")

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_id = deployment_id
        actual_id = body["id"]
        assert actual_id == expected_id
