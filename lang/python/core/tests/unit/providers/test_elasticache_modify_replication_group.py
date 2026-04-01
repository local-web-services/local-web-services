"""Tests for lws.providers.elasticache.routes -- ModifyReplicationGroup."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.elasticache.routes import create_elasticache_app


@pytest.fixture()
def client() -> TestClient:
    app = create_elasticache_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonElastiCache.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestModifyReplicationGroup:
    def test_modify_description(self, client: TestClient) -> None:
        # Arrange
        rg_id = "test-rg"
        expected_description = "updated description"
        _post(
            client,
            "CreateReplicationGroup",
            {
                "ReplicationGroupId": rg_id,
                "ReplicationGroupDescription": "original",
            },
        )

        # Act
        result = _post(
            client,
            "ModifyReplicationGroup",
            {
                "ReplicationGroupId": rg_id,
                "ReplicationGroupDescription": expected_description,
            },
        )

        # Assert
        actual_description = result["ReplicationGroup"]["Description"]
        assert (
            actual_description == expected_description
        ), f"Expected {expected_description!r} but got {actual_description!r}"

    def test_modify_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_error = "ReplicationGroupNotFoundFault"

        # Act
        result = _post(
            client,
            "ModifyReplicationGroup",
            {"ReplicationGroupId": "nonexistent"},
        )

        # Assert
        actual_error = result.get("__type", "")
        assert (
            actual_error == expected_error
        ), f"Expected {expected_error!r} but got {actual_error!r}"
