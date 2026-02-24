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


class TestListSecrets:
    def test_list(self, client: TestClient) -> None:
        secret_name_1 = "s1"
        secret_name_2 = "s2"
        _post(client, "CreateSecret", {"Name": secret_name_1})
        _post(client, "CreateSecret", {"Name": secret_name_2})
        result = _post(client, "ListSecrets", {})

        # Assert
        names = [s["Name"] for s in result["SecretList"]]
        assert secret_name_1 in names
        assert secret_name_2 in names
