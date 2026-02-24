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


class TestListSecretVersionIds:
    def test_versions(self, client: TestClient) -> None:
        secret_name = "versioned"
        _post(
            client,
            "CreateSecret",
            {"Name": secret_name, "SecretString": "v1"},
        )
        _post(
            client,
            "PutSecretValue",
            {"SecretId": secret_name, "SecretString": "v2"},
        )
        result = _post(client, "ListSecretVersionIds", {"SecretId": secret_name})

        # Assert
        expected_version_count = 2
        assert len(result["Versions"]) == expected_version_count
