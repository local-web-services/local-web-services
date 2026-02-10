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
        _post(client, "CreateSecret", {"Name": "s1"})
        _post(client, "CreateSecret", {"Name": "s2"})
        result = _post(client, "ListSecrets", {})
        names = [s["Name"] for s in result["SecretList"]]
        assert "s1" in names
        assert "s2" in names
