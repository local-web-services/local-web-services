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


class TestUpdateSecret:
    def test_update_description(self, client: TestClient) -> None:
        _post(client, "CreateSecret", {"Name": "upd"})
        _post(
            client,
            "UpdateSecret",
            {"SecretId": "upd", "Description": "updated"},
        )
        desc = _post(client, "DescribeSecret", {"SecretId": "upd"})
        assert desc["Description"] == "updated"

    def test_update_with_new_value(self, client: TestClient) -> None:
        _post(
            client,
            "CreateSecret",
            {"Name": "upd2", "SecretString": "old"},
        )
        result = _post(
            client,
            "UpdateSecret",
            {"SecretId": "upd2", "SecretString": "new"},
        )
        assert "VersionId" in result

        got = _post(client, "GetSecretValue", {"SecretId": "upd2"})
        assert got["SecretString"] == "new"
