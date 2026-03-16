"""Tests for lws.providers.rds.routes -- DescribeDBClusters."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.rds.routes import create_rds_app


@pytest.fixture()
def client() -> TestClient:
    app = create_rds_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonRDSv19.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestDescribeDBClusters:
    def test_describe_all_clusters(self, client: TestClient) -> None:
        # Arrange
        cluster_id_a = "desc-cl-a"
        cluster_id_b = "desc-cl-b"
        expected_count = 2
        _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id_a})
        _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id_b})

        # Act
        result = _post(client, "DescribeDBClusters", {})

        # Assert
        assert len(result["DBClusters"]) == expected_count
        ids = [c["DBClusterIdentifier"] for c in result["DBClusters"]]
        assert cluster_id_a in ids
        assert cluster_id_b in ids

    def test_describe_by_identifier(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "desc-cl-single"
        expected_cluster_id = cluster_id
        _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id})

        # Act
        result = _post(
            client,
            "DescribeDBClusters",
            {"DBClusterIdentifier": cluster_id},
        )

        # Assert
        expected_count = 1
        assert len(result["DBClusters"]) == expected_count
        actual_cluster_id = result["DBClusters"][0]["DBClusterIdentifier"]
        assert actual_cluster_id == expected_cluster_id

    def test_describe_not_found_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "DBClusterNotFoundFault"

        # Act
        result = _post(
            client,
            "DescribeDBClusters",
            {"DBClusterIdentifier": "no-such-cluster"},
        )

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type
