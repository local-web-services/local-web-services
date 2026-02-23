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


class TestDeleteAndRestore:
    def test_soft_delete(self, client: TestClient) -> None:
        secret_name = "del-soft"
        expected_secret_value = "x"
        _post(
            client,
            "CreateSecret",
            {"Name": secret_name, "SecretString": expected_secret_value},
        )
        _post(client, "DeleteSecret", {"SecretId": secret_name})

        # Assert - listed secrets should not include deleted
        listed = _post(client, "ListSecrets", {})
        names = [s["Name"] for s in listed["SecretList"]]
        assert secret_name not in names

        # But can restore
        _post(client, "RestoreSecret", {"SecretId": secret_name})
        got = _post(client, "GetSecretValue", {"SecretId": secret_name})
        assert got["SecretString"] == expected_secret_value

    def test_force_delete(self, client: TestClient) -> None:
        secret_name = "del-force"
        _post(client, "CreateSecret", {"Name": secret_name})
        _post(
            client,
            "DeleteSecret",
            {"SecretId": secret_name, "ForceDeleteWithoutRecovery": True},
        )
        result = _post(client, "DescribeSecret", {"SecretId": secret_name})

        # Assert
        expected_error_type = "ResourceNotFoundException"
        assert result["__type"] == expected_error_type
