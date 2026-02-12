"""Integration test for ElastiCache CreateCacheCluster."""

from __future__ import annotations

import httpx


class TestCreateCacheCluster:
    async def test_create_cache_cluster(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_cluster_status = "available"
        cluster_id = "int-test-cluster"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonElastiCache.CreateCacheCluster"},
            json={"CacheClusterId": cluster_id},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_cluster_id = body["CacheCluster"]["CacheClusterId"]
        actual_status = body["CacheCluster"]["CacheClusterStatus"]
        assert actual_cluster_id == cluster_id
        assert actual_status == expected_cluster_status
        assert "ARN" in body["CacheCluster"]

    async def test_create_duplicate_returns_error(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "CacheClusterAlreadyExists"
        cluster_id = "int-dup-cluster"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonElastiCache.CreateCacheCluster"},
            json={"CacheClusterId": cluster_id},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonElastiCache.CreateCacheCluster"},
            json={"CacheClusterId": cluster_id},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type

    async def test_create_without_id_returns_error(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "InvalidParameterValue"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonElastiCache.CreateCacheCluster"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
