"""Tests for lws.providers.ssm.routes -- SSM Parameter Store operations."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.ssm.routes import create_ssm_app


@pytest.fixture()
def client() -> TestClient:
    app = create_ssm_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonSSM.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestGetParametersByPath:
    def test_non_recursive(self, client: TestClient) -> None:
        direct_child = "/app/key1"
        nested_child = "/app/sub/key2"
        _post(client, "PutParameter", {"Name": direct_child, "Value": "v1"})
        _post(client, "PutParameter", {"Name": nested_child, "Value": "v2"})
        result = _post(client, "GetParametersByPath", {"Path": "/app/", "Recursive": False})

        # Assert
        names = [p["Name"] for p in result["Parameters"]]
        assert direct_child in names
        assert nested_child not in names

    def test_recursive(self, client: TestClient) -> None:
        direct_child = "/app/key1"
        nested_child = "/app/sub/key2"
        _post(client, "PutParameter", {"Name": direct_child, "Value": "v1"})
        _post(client, "PutParameter", {"Name": nested_child, "Value": "v2"})
        result = _post(client, "GetParametersByPath", {"Path": "/app/", "Recursive": True})

        # Assert
        names = [p["Name"] for p in result["Parameters"]]
        assert direct_child in names
        assert nested_child in names
