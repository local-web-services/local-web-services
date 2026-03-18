"""Tests for lws.providers.neptune.routes -- DeleteDBCluster."""

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


class TestDeleteDBCluster:
    def test_delete_cluster(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "del-neptune"
        expected_status = "deleting"
        _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id})

        # Act
        result = _post(
            client,
            "DeleteDBCluster",
            {"DBClusterIdentifier": cluster_id},
        )

        # Assert
        actual_status = result["DBCluster"]["Status"]
        assert actual_status == expected_status

    def test_delete_cluster_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "DBClusterNotFoundFault"

        # Act
        result = _post(
            client,
            "DeleteDBCluster",
            {"DBClusterIdentifier": "ghost"},
        )

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type

    def test_delete_removes_from_describe(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "remove-neptune"
        _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id})
        _post(client, "DeleteDBCluster", {"DBClusterIdentifier": cluster_id})

        # Act
        result = _post(client, "DescribeDBClusters")

        # Assert
        expected_count = 0
        actual_count = len(result["DBClusters"])
        assert actual_count == expected_count
