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


class TestDeleteParameter:
    def test_delete(self, client: TestClient) -> None:
        param_name = "/del"
        _post(client, "PutParameter", {"Name": param_name, "Value": "x"})
        _post(client, "DeleteParameter", {"Name": param_name})
        result = _post(client, "GetParameter", {"Name": param_name})

        # Assert
        expected_error_type = "ParameterNotFound"
        assert result["__type"] == expected_error_type

    def test_delete_missing(self, client: TestClient) -> None:
        result = _post(client, "DeleteParameter", {"Name": "/nope"})

        # Assert
        expected_error_type = "ParameterNotFound"
        assert result["__type"] == expected_error_type
