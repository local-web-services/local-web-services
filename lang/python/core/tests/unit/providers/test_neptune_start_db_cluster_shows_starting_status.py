"""Unit tests: Neptune StartDBCluster lifecycle — STARTING status during dwell."""

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


def _create_and_stop_cluster(client: TestClient, cluster_id: str) -> None:
    """Create a cluster and stop it instantly (no dwell) so it is in 'stopped' state."""
    _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id, "Engine": "neptune"})
    _post(client, "StopDBCluster", {"DBClusterIdentifier": cluster_id})


@pytest.fixture()
def starting_pair():
    """Returns (client, lc) where lc.modify_dwell_ms is initially 0 for stop setup."""
    lc = ResourceLifecycleConfig()
    lc.enabled = True
    lc.create_dwell_ms = 0
    lc.modify_dwell_ms = 0
    app, _ = create_neptune_app(lifecycle=lc)
    return TestClient(app), lc


@pytest.fixture()
def instant_start_client() -> TestClient:
    lc = ResourceLifecycleConfig()
    lc.enabled = True
    lc.create_dwell_ms = 0
    lc.modify_dwell_ms = 0
    app, _ = create_neptune_app(lifecycle=lc)
    return TestClient(app)


class TestStartDbClusterLifecycle:
    def test_start_db_cluster_returns_starting_status_during_dwell(self, starting_pair) -> None:
        # Arrange — create and stop cluster with zero dwell, then increase dwell for start
        client, lc = starting_pair
        cluster_id = "start-lc-cluster"
        _create_and_stop_cluster(client, cluster_id)
        lc.modify_dwell_ms = 5000
        expected_status = "starting"

        # Act
        result = _post(client, "StartDBCluster", {"DBClusterIdentifier": cluster_id})

        # Assert
        actual_status = result["DBCluster"]["Status"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_start_db_cluster_returns_available_status_with_zero_dwell(
        self, instant_start_client: TestClient
    ) -> None:
        # Arrange
        cluster_id = "start-instant-cluster"
        _create_and_stop_cluster(instant_start_client, cluster_id)
        expected_status = "available"

        # Act
        result = _post(instant_start_client, "StartDBCluster", {"DBClusterIdentifier": cluster_id})

        # Assert
        actual_status = result["DBCluster"]["Status"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_describe_cluster_shows_available_after_zero_dwell_start(
        self, instant_start_client: TestClient
    ) -> None:
        # Arrange
        cluster_id = "start-describe-cluster"
        _create_and_stop_cluster(instant_start_client, cluster_id)
        _post(instant_start_client, "StartDBCluster", {"DBClusterIdentifier": cluster_id})
        expected_status = "available"

        # Act
        result = _post(
            instant_start_client, "DescribeDBClusters", {"DBClusterIdentifier": cluster_id}
        )

        # Assert
        actual_status = result["DBClusters"][0]["Status"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
