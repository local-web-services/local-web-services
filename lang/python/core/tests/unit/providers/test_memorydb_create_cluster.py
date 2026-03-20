"""Tests for lws.providers.memorydb.routes -- CreateCluster."""

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


class TestCreateCluster:
    def test_create_cluster(self, client: TestClient) -> None:
        # Arrange
        cluster_name = "my-memorydb"
        expected_status = "available"
        expected_node_type = "db.t4g.small"

        # Act
        result = _post(client, "CreateCluster", {"ClusterName": cluster_name})

        # Assert
        actual_name = result["Cluster"]["Name"]
        actual_status = result["Cluster"]["Status"]
        actual_node_type = result["Cluster"]["NodeType"]
        assert actual_name == cluster_name, f"Expected {cluster_name!r} but got {actual_name!r}"
        assert actual_status == expected_status, f"Expected {expected_status!r} but got {actual_status!r}"
        assert actual_node_type == expected_node_type, f"Expected {expected_node_type!r} but got {actual_node_type!r}"
        assert "ARN" in result["Cluster"], f'Expected {"ARN"!r} to be in {result["Cluster"]!r}'
        assert "ClusterEndpoint" in result["Cluster"], f'Expected {"ClusterEndpoint"!r} to be in {result["Cluster"]!r}'

    def test_create_cluster_with_custom_fields(self, client: TestClient) -> None:
        # Arrange
        cluster_name = "custom-memorydb"
        expected_node_type = "db.r6g.large"
        expected_num_shards = 3

        # Act
        result = _post(
            client,
            "CreateCluster",
            {
                "ClusterName": cluster_name,
                "NodeType": expected_node_type,
                "NumShards": expected_num_shards,
            },
        )

        # Assert
        actual_node_type = result["Cluster"]["NodeType"]
        actual_num_shards = result["Cluster"]["NumShards"]
        assert actual_node_type == expected_node_type, f"Expected {expected_node_type!r} but got {actual_node_type!r}"
        assert actual_num_shards == expected_num_shards, f"Expected {expected_num_shards!r} but got {actual_num_shards!r}"

    def test_create_duplicate_returns_error(self, client: TestClient) -> None:
        # Arrange
        cluster_name = "dup-memorydb"
        expected_error_type = "ClusterAlreadyExistsFault"
        _post(client, "CreateCluster", {"ClusterName": cluster_name})

        # Act
        result = _post(client, "CreateCluster", {"ClusterName": cluster_name})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type, f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    def test_create_without_name_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "InvalidParameterValue"

        # Act
        result = _post(client, "CreateCluster", {})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type, f"Expected {expected_error_type!r} but got {actual_error_type!r}"
