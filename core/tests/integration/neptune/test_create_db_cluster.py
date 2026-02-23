"""Integration test for Neptune CreateDBCluster."""

from __future__ import annotations

import httpx


class TestCreateDBCluster:
    async def test_create_db_cluster(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        cluster_id = "int-neptune-cluster"
        expected_engine = "neptune"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonNeptune.CreateDBCluster"},
            json={
                "DBClusterIdentifier": cluster_id,
                "Engine": "neptune",
            },
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_identifier = body["DBCluster"]["DBClusterIdentifier"]
        actual_engine = body["DBCluster"]["Engine"]
        assert actual_identifier == cluster_id
        assert actual_engine == expected_engine
        assert "DBClusterArn" in body["DBCluster"]

    async def test_create_duplicate_cluster(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "DBClusterAlreadyExistsFault"
        cluster_id = "int-neptune-dup"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonNeptune.CreateDBCluster"},
            json={"DBClusterIdentifier": cluster_id},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonNeptune.CreateDBCluster"},
            json={"DBClusterIdentifier": cluster_id},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
