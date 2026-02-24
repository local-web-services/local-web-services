"""Integration test for API Gateway CreateDeployment."""

from __future__ import annotations

import httpx


class TestCreateDeployment:
    async def test_create_deployment(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 201
        create_resp = await client.post("/restapis", json={"name": "int-create-deployment"})
        api_id = create_resp.json()["id"]

        # Act
        response = await client.post(
            f"/restapis/{api_id}/deployments",
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "id" in body
