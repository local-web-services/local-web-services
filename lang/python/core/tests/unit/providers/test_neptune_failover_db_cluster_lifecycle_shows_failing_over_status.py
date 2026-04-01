"""Unit tests: Neptune FailoverDBCluster lifecycle — FAILING_OVER status during dwell."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers._shared._cluster_db_state import _ClusterDBState
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


def _create_cluster_multi_az(client: TestClient, state: _ClusterDBState, cluster_id: str) -> None:
    _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id, "Engine": "neptune"})
    state.clusters[cluster_id].multi_az = True


def _make_lifecycle_client(create_dwell_ms: int, modify_dwell_ms: int) -> tuple:
    lc = ResourceLifecycleConfig()
    lc.enabled = True
    lc.create_dwell_ms = create_dwell_ms
    lc.modify_dwell_ms = modify_dwell_ms
    app, state = create_neptune_app(lifecycle=lc)
    return TestClient(app), state


@pytest.fixture()
def failover_pair():
    return _make_lifecycle_client(create_dwell_ms=0, modify_dwell_ms=5000)


@pytest.fixture()
def instant_failover_pair():
    return _make_lifecycle_client(create_dwell_ms=0, modify_dwell_ms=0)


class TestFailoverDbClusterLifecycle:
    def test_failover_cluster_shows_failing_over_status_during_dwell(self, failover_pair) -> None:
        # Arrange
        client, state = failover_pair
        cluster_id = "failover-lc-cluster"
        _create_cluster_multi_az(client, state, cluster_id)
        expected_status = "failing_over"

        # Act
        _post(client, "FailoverDBCluster", {"DBClusterIdentifier": cluster_id})
        result = _post(client, "DescribeDBClusters", {"DBClusterIdentifier": cluster_id})

        # Assert
        actual_status = result["DBClusters"][0]["Status"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_describe_cluster_shows_available_after_zero_dwell_failover(
        self, instant_failover_pair
    ) -> None:
        # Arrange
        client, state = instant_failover_pair
        cluster_id = "failover-instant-cluster"
        _create_cluster_multi_az(client, state, cluster_id)
        expected_status = "available"

        # Act
        _post(client, "FailoverDBCluster", {"DBClusterIdentifier": cluster_id})
        result = _post(client, "DescribeDBClusters", {"DBClusterIdentifier": cluster_id})

        # Assert
        actual_status = result["DBClusters"][0]["Status"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
