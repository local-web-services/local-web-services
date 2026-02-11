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


class TestGetParameters:
    def test_get_multiple(self, client: TestClient) -> None:
        _post(client, "PutParameter", {"Name": "/a", "Value": "1"})
        _post(client, "PutParameter", {"Name": "/b", "Value": "2"})
        result = _post(client, "GetParameters", {"Names": ["/a", "/b", "/missing"]})

        # Assert
        expected_valid_count = 2
        expected_invalid = ["/missing"]
        assert len(result["Parameters"]) == expected_valid_count
        assert result["InvalidParameters"] == expected_invalid
