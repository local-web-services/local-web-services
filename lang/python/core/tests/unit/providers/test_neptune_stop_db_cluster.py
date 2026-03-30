"""Tests for Neptune StopDBCluster operation."""

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
    app, _ = create_neptune_app()

    return TestClient(app)


class TestStopDbCluster:
    def test_stop_db_cluster_returns_stopped_status(self, client: TestClient) -> None:
        # Arrange
        expected_status = "stopped"
        cluster_id = "stop-cluster-1"
        _make_request(
            client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id, "Engine": "neptune"}
        )

        # Act
        response = _make_request(client, "StopDBCluster", {"DBClusterIdentifier": cluster_id})

        # Assert
        actual_status = response.json()["DBCluster"]["Status"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_stop_db_cluster_not_found_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_code = "DBClusterNotFoundFault"

        # Act
        response = _make_request(client, "StopDBCluster", {"DBClusterIdentifier": "nonexistent"})

        # Assert
        actual_error_code = response.json().get("__type")
        assert (
            actual_error_code == expected_error_code
        ), f"Expected {expected_error_code!r} but got {actual_error_code!r}"
