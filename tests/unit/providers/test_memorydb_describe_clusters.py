"""Tests for lws.providers.memorydb.routes -- DescribeClusters."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.memorydb.routes import create_memorydb_app


@pytest.fixture()
def client() -> TestClient:
    app = create_memorydb_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonMemoryDB.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestDescribeClusters:
    def test_describe_all_empty(self, client: TestClient) -> None:
        # Arrange
        expected_count = 0

        # Act
        result = _post(client, "DescribeClusters", {})

        # Assert
        actual_count = len(result["Clusters"])
        assert actual_count == expected_count

    def test_describe_all(self, client: TestClient) -> None:
        # Arrange
        cluster_a = "cluster-a"
        cluster_b = "cluster-b"
        expected_count = 2
        _post(client, "CreateCluster", {"ClusterName": cluster_a})
        _post(client, "CreateCluster", {"ClusterName": cluster_b})

        # Act
        result = _post(client, "DescribeClusters", {})

        # Assert
        actual_count = len(result["Clusters"])
        assert actual_count == expected_count
        actual_names = [c["Name"] for c in result["Clusters"]]
        assert cluster_a in actual_names
        assert cluster_b in actual_names

    def test_describe_by_name(self, client: TestClient) -> None:
        # Arrange
        cluster_name = "specific-memorydb"
        _post(client, "CreateCluster", {"ClusterName": cluster_name})

        # Act
        result = _post(client, "DescribeClusters", {"ClusterName": cluster_name})

        # Assert
        assert len(result["Clusters"]) == 1
        actual_name = result["Clusters"][0]["Name"]
        assert actual_name == cluster_name

    def test_describe_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "ClusterNotFoundFault"

        # Act
        result = _post(client, "DescribeClusters", {"ClusterName": "no-such-cluster"})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type
