"""Integration test for ElastiCache DescribeCacheClusters."""

from __future__ import annotations

import httpx


class TestDescribeCacheClusters:
    async def test_describe_empty(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 0

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonElastiCache.DescribeCacheClusters"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_count = len(body["CacheClusters"])
        assert actual_count == expected_count

    async def test_describe_after_create(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 2
        cluster_id_a = "int-desc-a"
        cluster_id_b = "int-desc-b"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonElastiCache.CreateCacheCluster"},
            json={"CacheClusterId": cluster_id_a},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonElastiCache.CreateCacheCluster"},
            json={"CacheClusterId": cluster_id_b},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonElastiCache.DescribeCacheClusters"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_count = len(body["CacheClusters"])
        assert actual_count == expected_count
        actual_ids = [c["CacheClusterId"] for c in body["CacheClusters"]]
        assert cluster_id_a in actual_ids
        assert cluster_id_b in actual_ids

    async def test_describe_by_id(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        cluster_id = "int-desc-specific"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonElastiCache.CreateCacheCluster"},
            json={"CacheClusterId": cluster_id},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonElastiCache.DescribeCacheClusters"},
            json={"CacheClusterId": cluster_id},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["CacheClusters"]) == 1
        actual_id = body["CacheClusters"][0]["CacheClusterId"]
        assert actual_id == cluster_id

    async def test_describe_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "CacheClusterNotFound"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonElastiCache.DescribeCacheClusters"},
            json={"CacheClusterId": "nonexistent"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
