"""Tests for CancelRotateSecret and ReplicateSecretToRegions operations."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.secretsmanager.routes import create_secretsmanager_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_secretsmanager_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> tuple[int, dict]:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"secretsmanager.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.status_code, resp.json()


class TestCancelRotateSecret:
    def test_cancel_rotate_secret_returns_arn_and_name(self, client: TestClient) -> None:
        # Arrange
        expected_name = "my-secret"
        _post(client, "CreateSecret", {"Name": expected_name, "SecretString": "value"})

        # Act
        actual_status, actual_body = _post(
            client, "CancelRotateSecret", {"SecretId": expected_name}
        )

        # Assert
        assert actual_status == 200, f"Expected 200 but got {actual_status!r}"
        assert actual_body["Name"] == expected_name, (
            f"Expected {expected_name!r} but got {actual_body['Name']!r}"
        )
        assert "ARN" in actual_body, f'Expected "ARN" to be in {actual_body!r}'

    def test_cancel_rotate_secret_not_found_returns_404(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "ResourceNotFoundException"
        expected_status = 400

        # Act
        actual_status, actual_body = _post(
            client, "CancelRotateSecret", {"SecretId": "nonexistent"}
        )

        # Assert
        assert actual_status == expected_status, (
            f"Expected {expected_status!r} but got {actual_status!r}"
        )
        assert actual_body["__type"] == expected_error_type, (
            f"Expected {expected_error_type!r} but got {actual_body['__type']!r}"
        )


class TestReplicateSecretToRegions:
    def test_replicate_returns_replication_status(self, client: TestClient) -> None:
        # Arrange
        expected_name = "replicated-secret"
        expected_region = "eu-west-1"
        expected_status_value = "InSync"
        _post(client, "CreateSecret", {"Name": expected_name})

        # Act
        actual_status, actual_body = _post(
            client,
            "ReplicateSecretToRegions",
            {
                "SecretId": expected_name,
                "AddReplicaRegions": [{"Region": expected_region}],
            },
        )

        # Assert
        assert actual_status == 200, f"Expected 200 but got {actual_status!r}"
        actual_replication = actual_body.get("ReplicationStatus", [])
        assert len(actual_replication) == 1, (
            f"Expected 1 replication status but got {len(actual_replication)!r}"
        )
        assert actual_replication[0]["Region"] == expected_region, (
            f"Expected {expected_region!r} but got {actual_replication[0]['Region']!r}"
        )
        assert actual_replication[0]["Status"] == expected_status_value, (
            f"Expected {expected_status_value!r} but got {actual_replication[0]['Status']!r}"
        )
