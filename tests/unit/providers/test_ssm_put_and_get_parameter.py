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
        param_name = "/app/key"
        expected_value = "hello"
        result = _post(client, "PutParameter", {"Name": param_name, "Value": expected_value})

        # Assert
        expected_version = 1
        expected_type = "String"
        assert result["Version"] == expected_version

        result = _post(client, "GetParameter", {"Name": param_name})
        assert result["Parameter"]["Name"] == param_name
        assert result["Parameter"]["Value"] == expected_value
        assert result["Parameter"]["Type"] == expected_type

    def test_put_overwrite_increments_version(self, client: TestClient) -> None:
        param_name = "/v"
        _post(client, "PutParameter", {"Name": param_name, "Value": "1"})
        expected_new_value = "2"
        result = _post(
            client,
            "PutParameter",
            {"Name": param_name, "Value": expected_new_value, "Overwrite": True},
        )

        # Assert
        expected_version = 2
        assert result["Version"] == expected_version

        got = _post(client, "GetParameter", {"Name": param_name})
        assert got["Parameter"]["Value"] == expected_new_value

    def test_put_without_overwrite_returns_error(self, client: TestClient) -> None:
        param_name = "/dup"
        _post(client, "PutParameter", {"Name": param_name, "Value": "a"})
        result = _post(client, "PutParameter", {"Name": param_name, "Value": "b"})

        # Assert
        expected_error_type = "ParameterAlreadyExists"
        assert result["__type"] == expected_error_type

    def test_get_missing_parameter(self, client: TestClient) -> None:
        result = _post(client, "GetParameter", {"Name": "/missing"})

        # Assert
        expected_error_type = "ParameterNotFound"
        assert result["__type"] == expected_error_type

    def test_secure_string_masked_without_decryption(self, client: TestClient) -> None:
        param_name = "/secret"
        secret_value = "s3cr3t"
        _post(
            client,
            "PutParameter",
            {"Name": param_name, "Value": secret_value, "Type": "SecureString"},
        )
        result = _post(client, "GetParameter", {"Name": param_name})

        # Assert - masked without decryption
        expected_masked_value = "***"
        assert result["Parameter"]["Value"] == expected_masked_value

        result = _post(
            client,
            "GetParameter",
            {"Name": param_name, "WithDecryption": True},
        )
        # Assert - decrypted
        assert result["Parameter"]["Value"] == secret_value
