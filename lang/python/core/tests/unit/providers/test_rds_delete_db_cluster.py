"""Tests for lws.providers.rds.routes -- DeleteDBCluster."""

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


class TestDeleteDBCluster:
    def test_delete_cluster(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "del-cluster"
        expected_cluster_id = cluster_id
        expected_status = "deleting"
        _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id})

        # Act
        result = _post(client, "DeleteDBCluster", {"DBClusterIdentifier": cluster_id})

        # Assert
        actual_cluster_id = result["DBCluster"]["DBClusterIdentifier"]
        actual_status = result["DBCluster"]["Status"]
        assert (
            actual_cluster_id == expected_cluster_id
        ), f"Expected {expected_cluster_id!r} but got {actual_cluster_id!r}"
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_delete_cluster_removes_from_describe(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "del-gone-cluster"
        _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id})
        _post(client, "DeleteDBCluster", {"DBClusterIdentifier": cluster_id})

        # Act
        result = _post(client, "DescribeDBClusters", {})

        # Assert
        ids = [c["DBClusterIdentifier"] for c in result["DBClusters"]]
        assert cluster_id not in ids, f"Expected {cluster_id!r} to not be in {ids!r}"

    def test_delete_not_found_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "DBClusterNotFoundFault"

        # Act
        result = _post(
            client,
            "DeleteDBCluster",
            {"DBClusterIdentifier": "no-such-cluster"},
        )

        # Assert
        actual_error_type = result["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
