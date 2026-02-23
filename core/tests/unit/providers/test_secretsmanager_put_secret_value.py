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


class TestPutSecretValue:
    def test_put_new_version(self, client: TestClient) -> None:
        secret_name = "rotate"
        expected_new_value = "v2"
        _post(
            client,
            "CreateSecret",
            {"Name": secret_name, "SecretString": "v1"},
        )
        result = _post(
            client,
            "PutSecretValue",
            {"SecretId": secret_name, "SecretString": expected_new_value},
        )

        # Assert
        assert "VersionId" in result

        got = _post(client, "GetSecretValue", {"SecretId": secret_name})
        assert got["SecretString"] == expected_new_value

    def test_previous_version_gets_awsprevious(self, client: TestClient) -> None:
        create = _post(
            client,
            "CreateSecret",
            {"Name": "staged", "SecretString": "old"},
        )
        v1_id = create["VersionId"]

        _post(
            client,
            "PutSecretValue",
            {"SecretId": "staged", "SecretString": "new"},
        )

        versions = _post(
            client,
            "ListSecretVersionIds",
            {"SecretId": "staged"},
        )
        v1_info = next(v for v in versions["Versions"] if v["VersionId"] == v1_id)
        assert "AWSPREVIOUS" in v1_info["VersionStages"]
