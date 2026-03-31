"""Unit tests: Neptune snapshot lifecycle — delete with dwell removes snapshot from describe."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig
from lws.providers.neptune.routes import create_neptune_app

_TARGET_PREFIX = "AmazonNeptune."


def _make_request(client: TestClient, action: str, body: dict) -> TestClient:
    return client.post(
        "/",
        content=json.dumps(body),
        headers={"x-amz-target": f"{_TARGET_PREFIX}{action}"},
    )


@pytest.fixture()
def delete_dwell_client() -> TestClient:
    lc = ResourceLifecycleConfig()
    lc.enabled = True
    lc.delete_dwell_ms = 5000
    app, _ = create_neptune_app(lifecycle=lc)
    return TestClient(app)


class TestSnapshotLifecycleDeletingRemovesSnapshot:
    def test_describe_snapshot_returns_not_found_after_delete_with_dwell(
        self, delete_dwell_client: TestClient
    ) -> None:
        # Arrange
        cluster_id = "snap-del-dwell-cluster"
        snapshot_id = "snap-del-dwell"
        _make_request(
            delete_dwell_client,
            "CreateDBCluster",
            {"DBClusterIdentifier": cluster_id, "Engine": "neptune"},
        )
        _make_request(
            delete_dwell_client,
            "CreateDBClusterSnapshot",
            {
                "DBClusterSnapshotIdentifier": snapshot_id,
                "DBClusterIdentifier": cluster_id,
            },
        )
        _make_request(
            delete_dwell_client,
            "DeleteDBClusterSnapshot",
            {"DBClusterSnapshotIdentifier": snapshot_id},
        )
        expected_error = "DBClusterSnapshotNotFoundFault"

        # Act
        response = _make_request(
            delete_dwell_client,
            "DescribeDBClusterSnapshots",
            {"DBClusterSnapshotIdentifier": snapshot_id},
        )

        # Assert
        actual_error = response.json().get("__type")
        assert (
            actual_error == expected_error
        ), f"Expected {expected_error!r} but got {actual_error!r}"
