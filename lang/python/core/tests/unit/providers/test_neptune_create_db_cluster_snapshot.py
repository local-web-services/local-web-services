"""Tests for Neptune CreateDBClusterSnapshot operation."""

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


class TestCreateDbClusterSnapshot:
    def test_create_snapshot_returns_snapshot(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "snapshot-cluster-1"
        snapshot_id = "test-snapshot-1"
        _make_request(
            client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id, "Engine": "neptune"}
        )

        # Act
        response = _make_request(
            client,
            "CreateDBClusterSnapshot",
            {"DBClusterSnapshotIdentifier": snapshot_id, "DBClusterIdentifier": cluster_id},
        )

        # Assert
        actual_snapshot_id = response.json()["DBClusterSnapshot"]["DBClusterSnapshotIdentifier"]
        expected_snapshot_id = snapshot_id
        assert (
            actual_snapshot_id == expected_snapshot_id
        ), f"Expected {expected_snapshot_id!r} but got {actual_snapshot_id!r}"

    def test_create_snapshot_duplicate_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_code = "DBClusterSnapshotAlreadyExistsFault"
        cluster_id = "dup-snap-cluster"
        snapshot_id = "dup-snapshot"
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
            "CreateDBClusterSnapshot",
            {"DBClusterSnapshotIdentifier": snapshot_id, "DBClusterIdentifier": cluster_id},
        )

        # Assert
        actual_error_code = response.json().get("__type")
        assert (
            actual_error_code == expected_error_code
        ), f"Expected {expected_error_code!r} but got {actual_error_code!r}"
