"""Integration test for API Gateway ListRestApis."""

from __future__ import annotations

import httpx


class TestListRestApis:
    async def test_list_rest_apis(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        await client.post("/restapis", json={"name": "int-list-rest-apis"})

        # Act
        response = await client.get("/restapis")

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "item" in body
        assert len(body["item"]) >= 1
