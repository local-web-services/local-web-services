"""Tests for lws.providers.secretsmanager.routes -- ListTagsForResource."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.secretsmanager.routes import create_secretsmanager_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_secretsmanager_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"secretsmanager.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestListTagsForResource:
    def test_returns_tags_for_existing_secret(self, client: TestClient) -> None:
        # Arrange
        expected_key = "env"
        expected_value = "prod"
        secret_name = "tagged-secret"
        _post(client, "CreateSecret", {"Name": secret_name})
        _post(client, "TagResource", {"SecretId": secret_name, "Tags": [{"Key": expected_key, "Value": expected_value}]})

        # Act
        actual_result = _post(client, "ListTagsForResource", {"SecretId": secret_name})

        # Assert
        actual_tags = {t["Key"]: t["Value"] for t in actual_result["Tags"]}
        assert actual_tags[expected_key] == expected_value

    def test_returns_empty_tags_for_untagged_secret(self, client: TestClient) -> None:
        # Arrange
        expected_count = 0
        secret_name = "untagged-secret"
        _post(client, "CreateSecret", {"Name": secret_name})

        # Act
        actual_result = _post(client, "ListTagsForResource", {"SecretId": secret_name})

        # Assert
        actual_count = len(actual_result["Tags"])
        assert actual_count == expected_count

    def test_returns_error_for_missing_secret(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "ResourceNotFoundException"

        # Act
        actual_result = _post(client, "ListTagsForResource", {"SecretId": "nonexistent"})

        # Assert
        actual_error_type = actual_result.get("__type")
        assert actual_error_type == expected_error_type
