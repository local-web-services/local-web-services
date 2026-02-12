"""Tests for lws.providers.docdb.routes -- Instance operations."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.docdb.routes import create_docdb_app


@pytest.fixture()
def client() -> TestClient:
    app = create_docdb_app()
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


class TestCreateDBInstance:
    def test_create_instance(self, client: TestClient) -> None:
        # Arrange
        instance_id = "my-instance"
        cluster_id = "my-cluster"
        expected_engine = "docdb"
        expected_status = "available"

        # Act
        result = _post(
            client,
            "CreateDBInstance",
            {
                "DBInstanceIdentifier": instance_id,
                "DBInstanceClass": "db.r5.large",
                "Engine": "docdb",
                "DBClusterIdentifier": cluster_id,
            },
        )

        # Assert
        actual_instance = result["DBInstance"]
        actual_identifier = actual_instance["DBInstanceIdentifier"]
        actual_engine = actual_instance["Engine"]
        actual_status = actual_instance["DBInstanceStatus"]
        actual_cluster = actual_instance["DBClusterIdentifier"]
        assert actual_identifier == instance_id
        assert actual_engine == expected_engine
        assert actual_status == expected_status
        assert actual_cluster == cluster_id

    def test_create_duplicate_instance_returns_error(self, client: TestClient) -> None:
        # Arrange
        instance_id = "dup-instance"
        expected_error_type = "DBInstanceAlreadyExistsFault"
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": instance_id})

        # Act
        result = _post(client, "CreateDBInstance", {"DBInstanceIdentifier": instance_id})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type


class TestDescribeDBInstances:
    def test_describe_all_instances(self, client: TestClient) -> None:
        # Arrange
        expected_count = 2
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": "inst-a"})
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": "inst-b"})

        # Act
        result = _post(client, "DescribeDBInstances")

        # Assert
        actual_count = len(result["DBInstances"])
        assert actual_count == expected_count

    def test_describe_instance_by_id(self, client: TestClient) -> None:
        # Arrange
        instance_id = "specific-inst"
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": instance_id})

        # Act
        result = _post(
            client,
            "DescribeDBInstances",
            {"DBInstanceIdentifier": instance_id},
        )

        # Assert
        assert len(result["DBInstances"]) == 1
        actual_identifier = result["DBInstances"][0]["DBInstanceIdentifier"]
        assert actual_identifier == instance_id

    def test_describe_instance_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "DBInstanceNotFoundFault"

        # Act
        result = _post(
            client,
            "DescribeDBInstances",
            {"DBInstanceIdentifier": "nonexistent"},
        )

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type


class TestDeleteDBInstance:
    def test_delete_instance(self, client: TestClient) -> None:
        # Arrange
        instance_id = "del-inst"
        expected_status = "deleting"
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": instance_id})

        # Act
        result = _post(
            client,
            "DeleteDBInstance",
            {"DBInstanceIdentifier": instance_id},
        )

        # Assert
        actual_status = result["DBInstance"]["DBInstanceStatus"]
        assert actual_status == expected_status

    def test_delete_instance_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "DBInstanceNotFoundFault"

        # Act
        result = _post(
            client,
            "DeleteDBInstance",
            {"DBInstanceIdentifier": "ghost"},
        )

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type

    def test_delete_removes_from_describe(self, client: TestClient) -> None:
        # Arrange
        instance_id = "remove-inst"
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": instance_id})
        _post(client, "DeleteDBInstance", {"DBInstanceIdentifier": instance_id})

        # Act
        result = _post(client, "DescribeDBInstances")

        # Assert
        expected_count = 0
        actual_count = len(result["DBInstances"])
        assert actual_count == expected_count
