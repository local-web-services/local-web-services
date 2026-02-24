"""Tests for lws.providers.docdb.routes -- DescribeDBInstances operation."""

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
