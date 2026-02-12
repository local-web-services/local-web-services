"""Integration test for Neptune DescribeDBClusters."""

from __future__ import annotations

import httpx


class TestDescribeDBClusters:
    async def test_describe_all_clusters(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 2
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonNeptune.CreateDBCluster"},
            json={"DBClusterIdentifier": "int-nep-desc-a"},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonNeptune.CreateDBCluster"},
            json={"DBClusterIdentifier": "int-nep-desc-b"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonNeptune.DescribeDBClusters"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_count = len(body["DBClusters"])
        assert actual_count == expected_count

    async def test_describe_cluster_by_id(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        cluster_id = "int-nep-desc-specific"
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonNeptune.CreateDBCluster"},
            json={"DBClusterIdentifier": cluster_id},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonNeptune.DescribeDBClusters"},
            json={"DBClusterIdentifier": cluster_id},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["DBClusters"]) == 1
        actual_identifier = body["DBClusters"][0]["DBClusterIdentifier"]
        assert actual_identifier == cluster_id

    async def test_describe_cluster_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "DBClusterNotFoundFault"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonNeptune.DescribeDBClusters"},
            json={"DBClusterIdentifier": "nonexistent"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
