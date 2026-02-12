"""Tests for lws.providers.neptune.routes -- CreateDBCluster."""

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


class TestCreateDBCluster:
    def test_create_db_cluster(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "my-neptune-cluster"
        expected_engine = "neptune"
        expected_status = "available"

        # Act
        result = _post(
            client,
            "CreateDBCluster",
            {
                "DBClusterIdentifier": cluster_id,
                "Engine": "neptune",
            },
        )

        # Assert
        actual_cluster = result["DBCluster"]
        actual_identifier = actual_cluster["DBClusterIdentifier"]
        actual_engine = actual_cluster["Engine"]
        actual_status = actual_cluster["Status"]
        assert actual_identifier == cluster_id
        assert actual_engine == expected_engine
        assert actual_status == expected_status
        assert "DBClusterArn" in actual_cluster

    def test_create_duplicate_cluster_returns_error(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "dup-neptune-cluster"
        expected_error_type = "DBClusterAlreadyExistsFault"
        _post(
            client,
            "CreateDBCluster",
            {"DBClusterIdentifier": cluster_id},
        )

        # Act
        result = _post(
            client,
            "CreateDBCluster",
            {"DBClusterIdentifier": cluster_id},
        )

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type
