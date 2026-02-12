"""Tests for lws.providers.elasticache.routes -- DeleteCacheCluster."""

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


class TestDeleteCacheCluster:
    def test_delete_cache_cluster(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "del-cluster"
        expected_status = "deleted"
        _post(client, "CreateCacheCluster", {"CacheClusterId": cluster_id})

        # Act
        result = _post(client, "DeleteCacheCluster", {"CacheClusterId": cluster_id})

        # Assert
        actual_status = result["CacheCluster"]["CacheClusterStatus"]
        assert actual_status == expected_status

    def test_delete_removes_from_describe(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "gone-cluster"
        _post(client, "CreateCacheCluster", {"CacheClusterId": cluster_id})
        _post(client, "DeleteCacheCluster", {"CacheClusterId": cluster_id})

        # Act
        result = _post(client, "DescribeCacheClusters", {})

        # Assert
        actual_ids = [c["CacheClusterId"] for c in result["CacheClusters"]]
        assert cluster_id not in actual_ids

    def test_delete_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "CacheClusterNotFound"

        # Act
        result = _post(client, "DeleteCacheCluster", {"CacheClusterId": "no-such-cluster"})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type
