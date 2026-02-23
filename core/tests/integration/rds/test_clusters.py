"""Integration test for RDS CreateDBCluster, DescribeDBClusters, DeleteDBCluster."""

from __future__ import annotations

import httpx


class TestCreateDBCluster:
    async def test_create_cluster(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        cluster_id = "int-rds-cluster"
        expected_cluster_id = cluster_id

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.CreateDBCluster"},
            json={"DBClusterIdentifier": cluster_id, "Engine": "postgres"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_cluster_id = body["DBCluster"]["DBClusterIdentifier"]
        assert actual_cluster_id == expected_cluster_id
        assert "DBClusterArn" in body["DBCluster"]
        assert "Endpoint" in body["DBCluster"]

    async def test_create_duplicate_cluster_returns_error(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "DBClusterAlreadyExistsFault"
        cluster_id = "int-rds-dup-cluster"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.CreateDBCluster"},
            json={"DBClusterIdentifier": cluster_id},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.CreateDBCluster"},
            json={"DBClusterIdentifier": cluster_id},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type


class TestDescribeDBClusters:
    async def test_describe_clusters_after_create(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        cluster_id = "int-rds-desc-cluster"
        expected_cluster_id = cluster_id

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.CreateDBCluster"},
            json={"DBClusterIdentifier": cluster_id, "Engine": "postgres"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.DescribeDBClusters"},
            json={"DBClusterIdentifier": cluster_id},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        expected_count = 1
        assert len(body["DBClusters"]) == expected_count
        actual_cluster_id = body["DBClusters"][0]["DBClusterIdentifier"]
        assert actual_cluster_id == expected_cluster_id


class TestDeleteDBCluster:
    async def test_delete_cluster(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_delete_status = "deleting"
        cluster_id = "int-rds-del-cluster"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.CreateDBCluster"},
            json={"DBClusterIdentifier": cluster_id, "Engine": "postgres"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.DeleteDBCluster"},
            json={"DBClusterIdentifier": cluster_id},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_status = body["DBCluster"]["Status"]
        assert actual_status == expected_delete_status

    async def test_delete_cluster_removes_from_describe(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 0
        cluster_id = "int-rds-del-gone-cluster"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.CreateDBCluster"},
            json={"DBClusterIdentifier": cluster_id},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.DeleteDBCluster"},
            json={"DBClusterIdentifier": cluster_id},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonRDSv19.DescribeDBClusters"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["DBClusters"]) == expected_count
