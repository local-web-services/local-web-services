"""Unit tests: Neptune StopDBCluster lifecycle — STOPPING status during dwell."""

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


def _create_cluster(client: TestClient, cluster_id: str) -> None:
    _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id, "Engine": "neptune"})


def _make_lifecycle_client(create_dwell_ms: int, modify_dwell_ms: int) -> TestClient:
    lc = ResourceLifecycleConfig()
    lc.enabled = True
    lc.create_dwell_ms = create_dwell_ms
    lc.modify_dwell_ms = modify_dwell_ms
    app, _ = create_neptune_app(lifecycle=lc)
    return TestClient(app)


@pytest.fixture()
def stopping_client() -> TestClient:
    return _make_lifecycle_client(create_dwell_ms=0, modify_dwell_ms=5000)


@pytest.fixture()
def instant_stop_client() -> TestClient:
    return _make_lifecycle_client(create_dwell_ms=0, modify_dwell_ms=0)


class TestStopDbClusterLifecycle:
    def test_stop_db_cluster_returns_stopping_status_during_dwell(
        self, stopping_client: TestClient
    ) -> None:
        # Arrange
        cluster_id = "stop-lc-cluster"
        _create_cluster(stopping_client, cluster_id)
        expected_status = "stopping"

        # Act
        result = _post(stopping_client, "StopDBCluster", {"DBClusterIdentifier": cluster_id})

        # Assert
        actual_status = result["DBCluster"]["Status"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_stop_db_cluster_returns_stopped_status_with_zero_dwell(
        self, instant_stop_client: TestClient
    ) -> None:
        # Arrange
        cluster_id = "stop-instant-cluster"
        _create_cluster(instant_stop_client, cluster_id)
        expected_status = "stopped"

        # Act
        result = _post(instant_stop_client, "StopDBCluster", {"DBClusterIdentifier": cluster_id})

        # Assert
        actual_status = result["DBCluster"]["Status"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_describe_cluster_shows_stopped_after_zero_dwell_stop(
        self, instant_stop_client: TestClient
    ) -> None:
        # Arrange
        cluster_id = "stop-describe-cluster"
        _create_cluster(instant_stop_client, cluster_id)
        _post(instant_stop_client, "StopDBCluster", {"DBClusterIdentifier": cluster_id})
        expected_status = "stopped"

        # Act
        result = _post(
            instant_stop_client, "DescribeDBClusters", {"DBClusterIdentifier": cluster_id}
        )

        # Assert
        actual_status = result["DBClusters"][0]["Status"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
