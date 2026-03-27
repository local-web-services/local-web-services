"""Tests for Neptune RestoreDBClusterFromSnapshot operation."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.neptune.routes import create_neptune_app

_TARGET_PREFIX = "AmazonNeptune."


def _make_request(client: TestClient, action: str, body: dict) -> TestClient:
    return client.post(
        "/",
        content=json.dumps(body),
        headers={"x-amz-target": f"{_TARGET_PREFIX}{action}"},
    )


@pytest.fixture()
def client() -> TestClient:
    return TestClient(create_neptune_app())


class TestRestoreDbClusterFromSnapshot:
    def test_restore_cluster_from_snapshot(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "restore-src-cluster"
        snapshot_id = "restore-snapshot"
        restored_cluster_id = "restored-cluster"
        _make_request(
            client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id, "Engine": "neptune"}
        )
        _make_request(
            client,
            "CreateDBClusterSnapshot",
            {"DBClusterSnapshotIdentifier": snapshot_id, "DBClusterIdentifier": cluster_id},
        )

        # Act
        response = _make_request(
            client,
            "RestoreDBClusterFromSnapshot",
            {
                "DBClusterIdentifier": restored_cluster_id,
                "SnapshotIdentifier": snapshot_id,
                "Engine": "neptune",
            },
        )

        # Assert
        actual_cluster_id = response.json()["DBCluster"]["DBClusterIdentifier"]
        expected_cluster_id = restored_cluster_id
        assert (
            actual_cluster_id == expected_cluster_id
        ), f"Expected {expected_cluster_id!r} but got {actual_cluster_id!r}"
