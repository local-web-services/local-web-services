"""Unit tests: Neptune snapshot lifecycle — available after zero-dwell transition."""

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
def instant_client() -> TestClient:
    lc = ResourceLifecycleConfig()
    lc.enabled = True
    lc.create_dwell_ms = 0
    app, _ = create_neptune_app(lifecycle=lc)
    return TestClient(app)


class TestSnapshotLifecycleAvailableViaDwell:
    def test_describe_snapshot_shows_available_after_zero_dwell(
        self, instant_client: TestClient
    ) -> None:
        # Arrange
        cluster_id = "snap-lc-instant-cluster"
        snapshot_id = "snap-lc-instant"
        _make_request(
            instant_client,
            "CreateDBCluster",
            {"DBClusterIdentifier": cluster_id, "Engine": "neptune"},
        )
        _make_request(
            instant_client,
            "CreateDBClusterSnapshot",
            {
                "DBClusterSnapshotIdentifier": snapshot_id,
                "DBClusterIdentifier": cluster_id,
            },
        )
        expected_status = "available"

        # Act
        response = _make_request(
            instant_client,
            "DescribeDBClusterSnapshots",
            {"DBClusterSnapshotIdentifier": snapshot_id},
        )

        # Assert
        actual_status = response.json()["DBClusterSnapshots"][0]["Status"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
