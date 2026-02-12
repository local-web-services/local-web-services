"""Tests for lws.providers.rds.routes -- DeleteDBInstance."""

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


class TestDeleteDBInstance:
    def test_delete_instance(self, client: TestClient) -> None:
        # Arrange
        db_id = "del-instance"
        expected_db_id = db_id
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": db_id})

        # Act
        result = _post(client, "DeleteDBInstance", {"DBInstanceIdentifier": db_id})

        # Assert
        actual_db_id = result["DBInstance"]["DBInstanceIdentifier"]
        assert actual_db_id == expected_db_id

    def test_delete_instance_status_is_deleting(self, client: TestClient) -> None:
        # Arrange
        db_id = "del-status-instance"
        expected_status = "deleting"
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": db_id})

        # Act
        result = _post(client, "DeleteDBInstance", {"DBInstanceIdentifier": db_id})

        # Assert
        actual_status = result["DBInstance"]["DBInstanceStatus"]
        assert actual_status == expected_status

    def test_delete_removes_from_describe(self, client: TestClient) -> None:
        # Arrange
        db_id = "del-gone-instance"
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": db_id})
        _post(client, "DeleteDBInstance", {"DBInstanceIdentifier": db_id})

        # Act
        result = _post(client, "DescribeDBInstances", {})

        # Assert
        ids = [i["DBInstanceIdentifier"] for i in result["DBInstances"]]
        assert db_id not in ids

    def test_delete_not_found_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "DBInstanceNotFoundFault"

        # Act
        result = _post(
            client,
            "DeleteDBInstance",
            {"DBInstanceIdentifier": "no-such-instance"},
        )

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type
