"""Integration test for SSM GetParametersByPath."""

from __future__ import annotations

import httpx


class TestGetParametersByPath:
    async def test_get_parameters_by_path(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 2
        path = "/app/"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": "/app/key1", "Value": "value1"},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": "/app/key2", "Value": "value2"},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": "/other/key3", "Value": "value3"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.GetParametersByPath"},
            json={"Path": path},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["Parameters"]) == expected_count

    async def test_get_parameters_by_path_recursive(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 3
        path = "/app/"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": "/app/key1", "Value": "value1"},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": "/app/nested/key2", "Value": "value2"},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": "/app/nested/deep/key3", "Value": "value3"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.GetParametersByPath"},
            json={"Path": path, "Recursive": True},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["Parameters"]) == expected_count

    async def test_get_parameters_by_path_empty(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 0

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.GetParametersByPath"},
            json={"Path": "/nonexistent/"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["Parameters"]) == expected_count
