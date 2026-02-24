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
        assert actual_db_id == expected_db_id

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
        assert actual_engine == expected_engine
        assert actual_status == expected_status
        assert "Endpoint" in instance
        assert "DBInstanceArn" in instance
        assert "DBInstanceClass" in instance
        assert "AllocatedStorage" in instance

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
        assert actual_port == expected_port

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
        assert actual_port == expected_port

    def test_create_duplicate_returns_error(self, client: TestClient) -> None:
        # Arrange
        db_id = "dup-instance"
        expected_error_type = "DBInstanceAlreadyExistsFault"
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": db_id})

        # Act
        result = _post(client, "CreateDBInstance", {"DBInstanceIdentifier": db_id})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type

    def test_create_without_identifier_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "InvalidParameterValue"

        # Act
        result = _post(client, "CreateDBInstance", {})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type
