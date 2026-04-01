"""Unit tests: Neptune RestoreDBClusterFromSnapshot lifecycle — RESTORING status during dwell."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig
from lws.providers.neptune.routes import create_neptune_app

_TARGET_PREFIX = "AmazonNeptune."


def _post(client: TestClient, action: str, body: dict) -> dict:
    resp = client.post(
        "/",
        content=json.dumps(body),
        headers={"x-amz-target": f"{_TARGET_PREFIX}{action}"},
    )
    return resp.json()


def _setup_snapshot(client: TestClient, cluster_id: str, snapshot_id: str) -> None:
    _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id, "Engine": "neptune"})
    _post(
        client,
        "CreateDBClusterSnapshot",
        {"DBClusterSnapshotIdentifier": snapshot_id, "DBClusterIdentifier": cluster_id},
    )


def _make_lifecycle_client(create_dwell_ms: int, modify_dwell_ms: int) -> TestClient:
    lc = ResourceLifecycleConfig()
    lc.enabled = True
    lc.create_dwell_ms = create_dwell_ms
    lc.modify_dwell_ms = modify_dwell_ms
    app, _ = create_neptune_app(lifecycle=lc)
    return TestClient(app)


@pytest.fixture()
def restoring_client() -> TestClient:
    return _make_lifecycle_client(create_dwell_ms=0, modify_dwell_ms=5000)


@pytest.fixture()
def instant_restore_client() -> TestClient:
    return _make_lifecycle_client(create_dwell_ms=0, modify_dwell_ms=0)


class TestRestoreDbClusterLifecycle:
    def test_restore_cluster_shows_restoring_status_during_dwell(
        self, restoring_client: TestClient
    ) -> None:
        # Arrange
        src_cluster_id = "restore-src-cluster"
        snapshot_id = "restore-snapshot"
        restored_cluster_id = "restored-lc-cluster"
        _setup_snapshot(restoring_client, src_cluster_id, snapshot_id)
        expected_status = "restoring"

        # Act
        _post(
            restoring_client,
            "RestoreDBClusterFromSnapshot",
            {
                "DBClusterIdentifier": restored_cluster_id,
                "SnapshotIdentifier": snapshot_id,
                "Engine": "neptune",
            },
        )
        result = _post(
            restoring_client, "DescribeDBClusters", {"DBClusterIdentifier": restored_cluster_id}
        )

        # Assert
        actual_status = result["DBClusters"][0]["Status"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_describe_cluster_shows_available_after_zero_dwell_restore(
        self, instant_restore_client: TestClient
    ) -> None:
        # Arrange
        src_cluster_id = "restore-instant-src"
        snapshot_id = "restore-instant-snap"
        restored_cluster_id = "restored-instant-cluster"
        _setup_snapshot(instant_restore_client, src_cluster_id, snapshot_id)
        expected_status = "available"

        # Act
        _post(
            instant_restore_client,
            "RestoreDBClusterFromSnapshot",
            {
                "DBClusterIdentifier": restored_cluster_id,
                "SnapshotIdentifier": snapshot_id,
                "Engine": "neptune",
            },
        )
        result = _post(
            instant_restore_client,
            "DescribeDBClusters",
            {"DBClusterIdentifier": restored_cluster_id},
        )

        # Assert
        actual_status = result["DBClusters"][0]["Status"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
