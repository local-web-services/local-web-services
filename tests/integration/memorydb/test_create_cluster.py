"""Integration test for MemoryDB CreateCluster."""

from __future__ import annotations

import httpx


class TestCreateCluster:
    async def test_create_cluster(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_cluster_status = "available"
        cluster_name = "int-test-memorydb"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonMemoryDB.CreateCluster"},
            json={"ClusterName": cluster_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_name = body["Cluster"]["Name"]
        actual_status = body["Cluster"]["Status"]
        assert actual_name == cluster_name
        assert actual_status == expected_cluster_status
        assert "ARN" in body["Cluster"]

    async def test_create_duplicate_returns_error(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "ClusterAlreadyExistsFault"
        cluster_name = "int-dup-memorydb"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonMemoryDB.CreateCluster"},
            json={"ClusterName": cluster_name},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonMemoryDB.CreateCluster"},
            json={"ClusterName": cluster_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type

    async def test_create_without_name_returns_error(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "InvalidParameterValue"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonMemoryDB.CreateCluster"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
