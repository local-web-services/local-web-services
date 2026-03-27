"""Tests for Neptune StartDBCluster operation."""

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


class TestStartDbCluster:
    def test_start_db_cluster_returns_available_status(self, client: TestClient) -> None:
        # Arrange
        expected_status = "available"
        cluster_id = "start-cluster-1"
        _make_request(
            client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id, "Engine": "neptune"}
        )
        _make_request(client, "StopDBCluster", {"DBClusterIdentifier": cluster_id})

        # Act
        response = _make_request(client, "StartDBCluster", {"DBClusterIdentifier": cluster_id})

        # Assert
        actual_status = response.json()["DBCluster"]["Status"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
