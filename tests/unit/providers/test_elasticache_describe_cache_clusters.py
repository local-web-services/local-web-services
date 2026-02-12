"""Tests for lws.providers.elasticache.routes -- DescribeCacheClusters."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.elasticache.routes import create_elasticache_app


@pytest.fixture()
def client() -> TestClient:
    app = create_elasticache_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonElastiCache.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestDescribeCacheClusters:
    def test_describe_all_empty(self, client: TestClient) -> None:
        # Arrange
        expected_count = 0

        # Act
        result = _post(client, "DescribeCacheClusters", {})

        # Assert
        actual_count = len(result["CacheClusters"])
        assert actual_count == expected_count

    def test_describe_all(self, client: TestClient) -> None:
        # Arrange
        cluster_id_a = "cluster-a"
        cluster_id_b = "cluster-b"
        expected_count = 2
        _post(client, "CreateCacheCluster", {"CacheClusterId": cluster_id_a})
        _post(client, "CreateCacheCluster", {"CacheClusterId": cluster_id_b})

        # Act
        result = _post(client, "DescribeCacheClusters", {})

        # Assert
        actual_count = len(result["CacheClusters"])
        assert actual_count == expected_count
        actual_ids = [c["CacheClusterId"] for c in result["CacheClusters"]]
        assert cluster_id_a in actual_ids
        assert cluster_id_b in actual_ids

    def test_describe_by_id(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "specific-cluster"
        _post(client, "CreateCacheCluster", {"CacheClusterId": cluster_id})

        # Act
        result = _post(client, "DescribeCacheClusters", {"CacheClusterId": cluster_id})

        # Assert
        assert len(result["CacheClusters"]) == 1
        actual_id = result["CacheClusters"][0]["CacheClusterId"]
        assert actual_id == cluster_id

    def test_describe_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "CacheClusterNotFound"

        # Act
        result = _post(client, "DescribeCacheClusters", {"CacheClusterId": "no-such-cluster"})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type
