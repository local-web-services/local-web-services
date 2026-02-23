"""Tests for lws.providers.memorydb.routes -- DeleteCluster."""

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


class TestDeleteCluster:
    def test_delete_cluster(self, client: TestClient) -> None:
        # Arrange
        cluster_name = "del-memorydb"
        expected_status = "deleted"
        _post(client, "CreateCluster", {"ClusterName": cluster_name})

        # Act
        result = _post(client, "DeleteCluster", {"ClusterName": cluster_name})

        # Assert
        actual_status = result["Cluster"]["Status"]
        assert actual_status == expected_status

    def test_delete_removes_from_describe(self, client: TestClient) -> None:
        # Arrange
        cluster_name = "gone-memorydb"
        _post(client, "CreateCluster", {"ClusterName": cluster_name})
        _post(client, "DeleteCluster", {"ClusterName": cluster_name})

        # Act
        result = _post(client, "DescribeClusters", {})

        # Assert
        actual_names = [c["Name"] for c in result["Clusters"]]
        assert cluster_name not in actual_names

    def test_delete_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "ClusterNotFoundFault"

        # Act
        result = _post(client, "DeleteCluster", {"ClusterName": "no-such-cluster"})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type
