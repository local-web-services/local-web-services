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


class TestGetSecretValue:
    def test_get_value(self, client: TestClient) -> None:
        secret_name = "test/secret"
        expected_secret_value = "s3cr3t"
        _post(
            client,
            "CreateSecret",
            {"Name": secret_name, "SecretString": expected_secret_value},
        )
        result = _post(client, "GetSecretValue", {"SecretId": secret_name})

        # Assert
        assert result["SecretString"] == expected_secret_value
        assert result["Name"] == secret_name
        assert "VersionId" in result

    def test_get_missing(self, client: TestClient) -> None:
        result = _post(client, "GetSecretValue", {"SecretId": "nope"})

        # Assert
        expected_error_type = "ResourceNotFoundException"
        assert result["__type"] == expected_error_type
