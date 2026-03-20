"""Tests for lws.providers.rds.routes -- CreateDBCluster."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.rds.routes import create_rds_app


@pytest.fixture()
def client() -> TestClient:
    app = create_rds_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonRDSv19.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestCreateDBCluster:
    def test_create_cluster(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "test-cluster"
        expected_cluster_id = cluster_id

        # Act
        result = _post(
            client,
            "CreateDBCluster",
            {"DBClusterIdentifier": cluster_id, "Engine": "postgres"},
        )

        # Assert
        actual_cluster_id = result["DBCluster"]["DBClusterIdentifier"]
        assert (
            actual_cluster_id == expected_cluster_id
        ), f"Expected {expected_cluster_id!r} but got {actual_cluster_id!r}"

    def test_create_cluster_response_fields(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "fields-cluster"
        expected_engine = "postgres"
        expected_status = "available"

        # Act
        result = _post(
            client,
            "CreateDBCluster",
            {"DBClusterIdentifier": cluster_id, "Engine": expected_engine},
        )

        # Assert
        cluster = result["DBCluster"]
        actual_engine = cluster["Engine"]
        actual_status = cluster["Status"]
        assert (
            actual_engine == expected_engine
        ), f"Expected {expected_engine!r} but got {actual_engine!r}"
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        assert "Endpoint" in cluster, f'Expected {"Endpoint"!r} to be in {cluster!r}'
        assert "DBClusterArn" in cluster, f'Expected {"DBClusterArn"!r} to be in {cluster!r}'
        assert "Port" in cluster, f'Expected {"Port"!r} to be in {cluster!r}'

    def test_create_duplicate_cluster_returns_error(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "dup-cluster"
        expected_error_type = "DBClusterAlreadyExistsFault"
        _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id})

        # Act
        result = _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id})

        # Assert
        actual_error_type = result["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    def test_create_cluster_without_identifier_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "InvalidParameterValue"

        # Act
        result = _post(client, "CreateDBCluster", {})

        # Assert
        actual_error_type = result["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
