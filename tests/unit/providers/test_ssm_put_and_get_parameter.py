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


class TestPutAndGetParameter:
    def test_put_then_get(self, client: TestClient) -> None:
        result = _post(client, "PutParameter", {"Name": "/app/key", "Value": "hello"})
        assert result["Version"] == 1

        result = _post(client, "GetParameter", {"Name": "/app/key"})
        assert result["Parameter"]["Name"] == "/app/key"
        assert result["Parameter"]["Value"] == "hello"
        assert result["Parameter"]["Type"] == "String"

    def test_put_overwrite_increments_version(self, client: TestClient) -> None:
        _post(client, "PutParameter", {"Name": "/v", "Value": "1"})
        result = _post(client, "PutParameter", {"Name": "/v", "Value": "2", "Overwrite": True})
        assert result["Version"] == 2

        got = _post(client, "GetParameter", {"Name": "/v"})
        assert got["Parameter"]["Value"] == "2"

    def test_put_without_overwrite_returns_error(self, client: TestClient) -> None:
        _post(client, "PutParameter", {"Name": "/dup", "Value": "a"})
        result = _post(client, "PutParameter", {"Name": "/dup", "Value": "b"})
        assert result["__type"] == "ParameterAlreadyExists"

    def test_get_missing_parameter(self, client: TestClient) -> None:
        result = _post(client, "GetParameter", {"Name": "/missing"})
        assert result["__type"] == "ParameterNotFound"

    def test_secure_string_masked_without_decryption(self, client: TestClient) -> None:
        _post(
            client,
            "PutParameter",
            {"Name": "/secret", "Value": "s3cr3t", "Type": "SecureString"},
        )
        result = _post(client, "GetParameter", {"Name": "/secret"})
        assert result["Parameter"]["Value"] == "***"

        result = _post(
            client,
            "GetParameter",
            {"Name": "/secret", "WithDecryption": True},
        )
        assert result["Parameter"]["Value"] == "s3cr3t"
