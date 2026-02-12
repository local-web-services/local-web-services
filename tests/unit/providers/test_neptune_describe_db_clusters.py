"""Tests for lws.providers.neptune.routes -- DescribeDBClusters."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.neptune.routes import create_neptune_app


@pytest.fixture()
def client() -> TestClient:
    app = create_neptune_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonNeptune.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestDescribeDBClusters:
    def test_describe_all_clusters(self, client: TestClient) -> None:
        # Arrange
        cluster_id_a = "neptune-a"
        cluster_id_b = "neptune-b"
        expected_count = 2
        _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id_a})
        _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id_b})

        # Act
        result = _post(client, "DescribeDBClusters")

        # Assert
        actual_count = len(result["DBClusters"])
        assert actual_count == expected_count

    def test_describe_cluster_by_id(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "specific-neptune"
        _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id})

        # Act
        result = _post(
            client,
            "DescribeDBClusters",
            {"DBClusterIdentifier": cluster_id},
        )

        # Assert
        assert len(result["DBClusters"]) == 1
        actual_identifier = result["DBClusters"][0]["DBClusterIdentifier"]
        assert actual_identifier == cluster_id

    def test_describe_cluster_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "DBClusterNotFoundFault"

        # Act
        result = _post(
            client,
            "DescribeDBClusters",
            {"DBClusterIdentifier": "nonexistent"},
        )

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type

    def test_describe_empty_returns_empty_list(self, client: TestClient) -> None:
        # Arrange
        expected_count = 0

        # Act
        result = _post(client, "DescribeDBClusters")

        # Assert
        actual_count = len(result["DBClusters"])
        assert actual_count == expected_count
