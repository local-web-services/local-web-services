"""Tests for ElastiCache per-resource container wiring."""

from __future__ import annotations

import json
from unittest.mock import AsyncMock

from fastapi.testclient import TestClient

from lws.providers.elasticache.routes import create_elasticache_app


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


class TestElastiCacheDataPlaneEndpoint:
    def test_with_container_manager_uses_real_endpoint(self) -> None:
        # Arrange
        expected_address = "localhost"
        expected_port = 16379
        mock_cm = AsyncMock()
        mock_cm.start_container.return_value = "localhost:16379"
        app = create_elasticache_app(container_manager=mock_cm)
        client = TestClient(app)

        # Act
        result = _post(
            client,
            "CreateCacheCluster",
            {"CacheClusterId": "test-cluster", "Engine": "redis"},
        )

        # Assert
        actual_endpoint = result["CacheCluster"]["ConfigurationEndpoint"]
        actual_address = actual_endpoint["Address"]
        actual_port = actual_endpoint["Port"]
        assert actual_address == expected_address
        assert actual_port == expected_port
        mock_cm.start_container.assert_called_once_with("test-cluster")

    def test_without_container_manager_uses_synthetic_endpoint(self) -> None:
        # Arrange
        expected_address = "test-cluster.cache.localhost"
        expected_port = 6379
        app = create_elasticache_app()
        client = TestClient(app)

        # Act
        result = _post(
            client,
            "CreateCacheCluster",
            {"CacheClusterId": "test-cluster", "Engine": "redis"},
        )

        # Assert
        actual_endpoint = result["CacheCluster"]["ConfigurationEndpoint"]
        actual_address = actual_endpoint["Address"]
        actual_port = actual_endpoint["Port"]
        assert actual_address == expected_address
        assert actual_port == expected_port

    def test_delete_cluster_stops_container(self) -> None:
        # Arrange
        mock_cm = AsyncMock()
        mock_cm.start_container.return_value = "localhost:16379"
        app = create_elasticache_app(container_manager=mock_cm)
        client = TestClient(app)
        _post(
            client,
            "CreateCacheCluster",
            {"CacheClusterId": "test-cluster", "Engine": "redis"},
        )

        # Act
        _post(client, "DeleteCacheCluster", {"CacheClusterId": "test-cluster"})

        # Assert
        mock_cm.stop_container.assert_called_once_with("test-cluster")
