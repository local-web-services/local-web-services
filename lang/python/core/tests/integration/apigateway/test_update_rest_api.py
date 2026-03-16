"""Integration test for API Gateway UpdateRestApi."""

from __future__ import annotations

import httpx


class TestUpdateRestApi:
    async def test_update_rest_api(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        create_resp = await client.post("/restapis", json={"name": "int-update-rest-api"})
        api_id = create_resp.json()["id"]

        # Act
        response = await client.patch(
            f"/restapis/{api_id}",
            json={
                "patchOperations": [
                    {"op": "replace", "path": "/name", "value": "int-updated"},
                ]
            },
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_name = "int-updated"
        actual_name = body["name"]
        assert actual_name == expected_name
