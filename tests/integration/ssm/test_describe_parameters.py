"""Integration test for SSM DescribeParameters."""

from __future__ import annotations

import httpx


class TestDescribeParameters:
    async def test_describe_parameters(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 2
        param_name_1 = "/app/param1"
        param_name_2 = "/app/param2"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name_1, "Value": "value1", "Description": "First param"},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name_2, "Value": "value2", "Description": "Second param"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.DescribeParameters"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["Parameters"]) == expected_count
        names = [p["Name"] for p in body["Parameters"]]
        assert param_name_1 in names
        assert param_name_2 in names

    async def test_describe_parameters_with_filter(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 1
        expected_name = "/app/filtered"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": expected_name, "Value": "value1"},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": "/other/param", "Value": "value2"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.DescribeParameters"},
            json={
                "ParameterFilters": [{"Key": "Name", "Option": "BeginsWith", "Values": ["/app/"]}]
            },
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["Parameters"]) == expected_count
        assert body["Parameters"][0]["Name"] == expected_name

    async def test_describe_parameters_empty(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 0

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.DescribeParameters"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["Parameters"]) == expected_count
