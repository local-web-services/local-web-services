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
        result = _post(
            client,
            "CreateSecret",
            {"Name": "app/key", "SecretString": "my-secret"},
        )
        assert result["Name"] == "app/key"
        assert "ARN" in result
        assert "VersionId" in result

    def test_create_without_value(self, client: TestClient) -> None:
        result = _post(client, "CreateSecret", {"Name": "empty-secret"})
        assert result["Name"] == "empty-secret"
        assert "VersionId" not in result

    def test_create_duplicate(self, client: TestClient) -> None:
        _post(client, "CreateSecret", {"Name": "dup"})
        result = _post(client, "CreateSecret", {"Name": "dup"})
        assert result["__type"] == "ResourceExistsException"
