"""Tests for lws.providers.secretsmanager.routes -- Secrets Manager operations."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.secretsmanager.routes import create_secretsmanager_app


@pytest.fixture()
def client() -> TestClient:
    app = create_secretsmanager_app()
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


class TestCreateSecret:
    def test_create_with_string(self, client: TestClient) -> None:
        expected_name = "app/key"
        result = _post(
            client,
            "CreateSecret",
            {"Name": expected_name, "SecretString": "my-secret"},
        )

        # Assert
        assert result["Name"] == expected_name
        assert "ARN" in result
        assert "VersionId" in result

    def test_create_without_value(self, client: TestClient) -> None:
        expected_name = "empty-secret"
        result = _post(client, "CreateSecret", {"Name": expected_name})

        # Assert
        assert result["Name"] == expected_name
        assert "VersionId" not in result

    def test_create_duplicate(self, client: TestClient) -> None:
        secret_name = "dup"
        _post(client, "CreateSecret", {"Name": secret_name})
        result = _post(client, "CreateSecret", {"Name": secret_name})

        # Assert
        expected_error_type = "ResourceExistsException"
        assert result["__type"] == expected_error_type
