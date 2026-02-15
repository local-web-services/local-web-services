"""Integration test for API Gateway ListDeployments."""

from __future__ import annotations

import httpx


class TestListDeployments:
    async def test_list_deployments(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post("/restapis", json={"name": "int-list-deployments"})
        api_id = create_resp.json()["id"]
        await client.post(f"/restapis/{api_id}/deployments", json={})

        # Act
        response = await client.get(f"/restapis/{api_id}/deployments")

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "item" in body
        assert len(body["item"]) >= 1
