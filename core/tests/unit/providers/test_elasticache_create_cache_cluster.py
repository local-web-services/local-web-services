"""Tests for lws.providers.elasticache.routes -- CreateCacheCluster."""

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


class TestCreateCacheCluster:
    def test_create_cache_cluster(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "my-cluster"
        expected_status = "available"
        expected_engine = "redis"

        # Act
        result = _post(client, "CreateCacheCluster", {"CacheClusterId": cluster_id})

        # Assert
        actual_cluster_id = result["CacheCluster"]["CacheClusterId"]
        actual_status = result["CacheCluster"]["CacheClusterStatus"]
        actual_engine = result["CacheCluster"]["Engine"]
        assert actual_cluster_id == cluster_id
        assert actual_status == expected_status
        assert actual_engine == expected_engine
        assert "ARN" in result["CacheCluster"]
        assert "ConfigurationEndpoint" in result["CacheCluster"]

    def test_create_cache_cluster_with_custom_fields(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "custom-cluster"
        expected_engine = "memcached"
        expected_num_nodes = 3
        expected_node_type = "cache.m5.large"

        # Act
        result = _post(
            client,
            "CreateCacheCluster",
            {
                "CacheClusterId": cluster_id,
                "Engine": expected_engine,
                "NumCacheNodes": expected_num_nodes,
                "CacheNodeType": expected_node_type,
            },
        )

        # Assert
        actual_engine = result["CacheCluster"]["Engine"]
        actual_num_nodes = result["CacheCluster"]["NumCacheNodes"]
        actual_node_type = result["CacheCluster"]["CacheNodeType"]
        assert actual_engine == expected_engine
        assert actual_num_nodes == expected_num_nodes
        assert actual_node_type == expected_node_type

    def test_create_duplicate_returns_error(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "dup-cluster"
        expected_error_type = "CacheClusterAlreadyExists"
        _post(client, "CreateCacheCluster", {"CacheClusterId": cluster_id})

        # Act
        result = _post(client, "CreateCacheCluster", {"CacheClusterId": cluster_id})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type

    def test_create_without_id_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "InvalidParameterValue"

        # Act
        result = _post(client, "CreateCacheCluster", {})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type
