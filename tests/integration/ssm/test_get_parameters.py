"""Integration test for SSM GetParameters."""

from __future__ import annotations

import httpx


class TestGetParameters:
    async def test_get_parameters(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        param_name_1 = "/app/param1"
        param_name_2 = "/app/param2"
        expected_value_1 = "value1"
        expected_value_2 = "value2"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name_1, "Value": expected_value_1},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name_2, "Value": expected_value_2},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.GetParameters"},
            json={"Names": [param_name_1, param_name_2]},
        )

        # Assert
        assert response.status_code == expected_status_code
