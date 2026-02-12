"""Tests for lws.providers.neptune.routes -- DeleteDBInstance operation."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.neptune.routes import create_neptune_app


@pytest.fixture()
def client() -> TestClient:
    app = create_neptune_app()
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


class TestDeleteDBInstance:
    def test_delete_instance(self, client: TestClient) -> None:
        # Arrange
        instance_id = "del-nep-inst"
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
        instance_id = "remove-nep-inst"
        _post(client, "CreateDBInstance", {"DBInstanceIdentifier": instance_id})
        _post(client, "DeleteDBInstance", {"DBInstanceIdentifier": instance_id})

        # Act
        result = _post(client, "DescribeDBInstances")

        # Assert
        expected_count = 0
        actual_count = len(result["DBInstances"])
        assert actual_count == expected_count
