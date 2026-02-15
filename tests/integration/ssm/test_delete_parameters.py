"""Integration test for SSM DeleteParameters."""

from __future__ import annotations

import httpx


class TestDeleteParameters:
    async def test_delete_parameters(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        param_name = "/app/to-delete-batch"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name, "Value": "value"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.DeleteParameters"},
            json={"Names": [param_name]},
        )

        # Assert
        assert response.status_code == expected_status_code
