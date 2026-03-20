"""Tests for lws.providers.rds.routes -- CreateDBInstance."""

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


class TestCreateDBInstance:
    def test_create_db_instance(self, client: TestClient) -> None:
        # Arrange
        db_id = "test-instance"
        expected_db_id = db_id

        # Act
        result = _post(
            client,
            "CreateDBInstance",
            {"DBInstanceIdentifier": db_id, "Engine": "postgres"},
        )

        # Assert
        actual_db_id = result["DBInstance"]["DBInstanceIdentifier"]
        assert (
            actual_db_id == expected_db_id
        ), f"Expected {expected_db_id!r} but got {actual_db_id!r}"

    def test_create_db_instance_response_fields(self, client: TestClient) -> None:
        # Arrange
        db_id = "fields-instance"
        expected_engine = "postgres"
        expected_status = "available"

        # Act
        result = _post(
            client,
            "CreateDBInstance",
            {"DBInstanceIdentifier": db_id, "Engine": expected_engine},
        )

        # Assert
        instance = result["DBInstance"]
        actual_engine = instance["Engine"]
        actual_status = instance["DBInstanceStatus"]
        assert (
            actual_engine == expected_engine
        ), f"Expected {expected_engine!r} but got {actual_engine!r}"
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        assert "Endpoint" in instance, f'Expected {"Endpoint"!r} to be in {instance!r}'
        assert "DBInstanceArn" in instance, f'Expected {"DBInstanceArn"!r} to be in {instance!r}'
        assert (
            "DBInstanceClass" in instance
        ), f'Expected {"DBInstanceClass"!r} to be in {instance!r}'
        assert (
            "AllocatedStorage" in instance
        ), f'Expected {"AllocatedStorage"!r} to be in {instance!r}'

    def test_create_db_instance_endpoint_port(self, client: TestClient) -> None:
        # Arrange
        db_id = "port-instance"
        expected_port = 5432

        # Act
        result = _post(
            client,
            "CreateDBInstance",
            {"DBInstanceIdentifier": db_id, "Engine": "postgres"},
        )

        # Assert
        actual_port = result["DBInstance"]["Endpoint"]["Port"]
        assert actual_port == expected_port, f"Expected {expected_port!r} but got {actual_port!r}"

    def test_create_mysql_instance_port(self, client: TestClient) -> None:
        # Arrange
        db_id = "mysql-instance"
        expected_port = 3306

        # Act
        result = _post(
            client,
            "CreateDBInstance",
            {"DBInstanceIdentifier": db_id, "Engine": "mysql"},
        )

        # Assert
        actual_port = result["DBInstance"]["Endpoint"]["Port"]
        assert actual_port == expected_port, f"Expected {expected_port!r} but got {actual_port!r}"

    def test_create_duplicate_returns_error(self, client: TestClient) -> None:
        # Arrange
        db_id = "dup-instance"
        expected_error_type = "DBInstanceAlreadyExistsFault"
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": db_id})

        # Act
        result = _post(client, "CreateDBInstance", {"DBInstanceIdentifier": db_id})

        # Assert
        actual_error_type = result["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    def test_create_without_identifier_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "InvalidParameterValue"

        # Act
        result = _post(client, "CreateDBInstance", {})

        # Assert
        actual_error_type = result["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
