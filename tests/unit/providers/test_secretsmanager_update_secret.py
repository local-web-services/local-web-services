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
        secret_name = "upd"
        expected_description = "updated"
        _post(client, "CreateSecret", {"Name": secret_name})
        _post(
            client,
            "UpdateSecret",
            {"SecretId": secret_name, "Description": expected_description},
        )
        desc = _post(client, "DescribeSecret", {"SecretId": secret_name})

        # Assert
        assert desc["Description"] == expected_description

    def test_update_with_new_value(self, client: TestClient) -> None:
        secret_name = "upd2"
        expected_new_value = "new"
        _post(
            client,
            "CreateSecret",
            {"Name": secret_name, "SecretString": "old"},
        )
        result = _post(
            client,
            "UpdateSecret",
            {"SecretId": secret_name, "SecretString": expected_new_value},
        )

        # Assert
        assert "VersionId" in result

        got = _post(client, "GetSecretValue", {"SecretId": secret_name})
        assert got["SecretString"] == expected_new_value
