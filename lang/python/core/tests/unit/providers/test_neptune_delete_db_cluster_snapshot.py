"""Tests for Neptune DeleteDBClusterSnapshot operation."""

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


class TestDeleteDbClusterSnapshot:
    def test_delete_snapshot_removes_snapshot(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "del-snap-cluster"
        snapshot_id = "del-snapshot"
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
            "DeleteDBClusterSnapshot",
            {"DBClusterSnapshotIdentifier": snapshot_id},
        )

        # Assert
        actual_snapshot_id = response.json()["DBClusterSnapshot"]["DBClusterSnapshotIdentifier"]
        expected_snapshot_id = snapshot_id
        assert (
            actual_snapshot_id == expected_snapshot_id
        ), f"Expected {expected_snapshot_id!r} but got {actual_snapshot_id!r}"
