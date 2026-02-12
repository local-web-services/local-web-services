"""Tests for lws.providers.rds.routes -- DescribeDBInstances."""

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


class TestDescribeDBInstances:
    def test_describe_all_instances(self, client: TestClient) -> None:
        # Arrange
        db_id_a = "desc-a"
        db_id_b = "desc-b"
        expected_count = 2
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": db_id_a})
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": db_id_b})

        # Act
        result = _post(client, "DescribeDBInstances", {})

        # Assert
        assert len(result["DBInstances"]) == expected_count
        ids = [i["DBInstanceIdentifier"] for i in result["DBInstances"]]
        assert db_id_a in ids
        assert db_id_b in ids

    def test_describe_by_identifier(self, client: TestClient) -> None:
        # Arrange
        db_id = "desc-single"
        expected_db_id = db_id
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": db_id})

        # Act
        result = _post(
            client,
            "DescribeDBInstances",
            {"DBInstanceIdentifier": db_id},
        )

        # Assert
        expected_count = 1
        assert len(result["DBInstances"]) == expected_count
        actual_db_id = result["DBInstances"][0]["DBInstanceIdentifier"]
        assert actual_db_id == expected_db_id

    def test_describe_not_found_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "DBInstanceNotFoundFault"

        # Act
        result = _post(
            client,
            "DescribeDBInstances",
            {"DBInstanceIdentifier": "no-such-instance"},
        )

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type

    def test_describe_empty_returns_empty_list(self, client: TestClient) -> None:
        # Arrange
        expected_count = 0

        # Act
        result = _post(client, "DescribeDBInstances", {})

        # Assert
        assert len(result["DBInstances"]) == expected_count
