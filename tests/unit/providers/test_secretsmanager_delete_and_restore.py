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
        _post(
            client,
            "CreateSecret",
            {"Name": "del-soft", "SecretString": "x"},
        )
        _post(client, "DeleteSecret", {"SecretId": "del-soft"})

        # Listed secrets should not include deleted
        listed = _post(client, "ListSecrets", {})
        names = [s["Name"] for s in listed["SecretList"]]
        assert "del-soft" not in names

        # But can restore
        _post(client, "RestoreSecret", {"SecretId": "del-soft"})
        got = _post(client, "GetSecretValue", {"SecretId": "del-soft"})
        assert got["SecretString"] == "x"

    def test_force_delete(self, client: TestClient) -> None:
        _post(client, "CreateSecret", {"Name": "del-force"})
        _post(
            client,
            "DeleteSecret",
            {"SecretId": "del-force", "ForceDeleteWithoutRecovery": True},
        )
        result = _post(client, "DescribeSecret", {"SecretId": "del-force"})
        assert result["__type"] == "ResourceNotFoundException"
