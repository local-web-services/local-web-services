"""Tests for lws.providers.neptune.routes -- CreateDBInstance operation."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.neptune.routes import create_neptune_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_neptune_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonNeptune.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestCreateDBInstance:
    def test_create_instance(self, client: TestClient) -> None:
        # Arrange
        instance_id = "neptune-inst"
        cluster_id = "neptune-cluster"
        expected_engine = "neptune"
        expected_status = "available"
        _post(
            client,
            "CreateDBCluster",
            {"DBClusterIdentifier": cluster_id, "Engine": "neptune"},
        )

        # Act
        result = _post(
            client,
            "CreateDBInstance",
            {
                "DBInstanceIdentifier": instance_id,
                "DBInstanceClass": "db.r5.large",
                "Engine": "neptune",
                "DBClusterIdentifier": cluster_id,
            },
        )

        # Assert
        actual_instance = result["DBInstance"]
        actual_identifier = actual_instance["DBInstanceIdentifier"]
        actual_engine = actual_instance["Engine"]
        actual_status = actual_instance["DBInstanceStatus"]
        actual_cluster = actual_instance["DBClusterIdentifier"]
        assert (
            actual_identifier == instance_id
        ), f"Expected {instance_id!r} but got {actual_identifier!r}"
        assert (
            actual_engine == expected_engine
        ), f"Expected {expected_engine!r} but got {actual_engine!r}"
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        assert actual_cluster == cluster_id, f"Expected {cluster_id!r} but got {actual_cluster!r}"

    def test_create_duplicate_instance_returns_error(self, client: TestClient) -> None:
        # Arrange
        instance_id = "dup-neptune-inst"
        expected_error_type = "DBInstanceAlreadyExistsFault"
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": instance_id})

        # Act
        result = _post(client, "CreateDBInstance", {"DBInstanceIdentifier": instance_id})

        # Assert
        actual_error_type = result["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
