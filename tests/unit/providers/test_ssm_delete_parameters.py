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


class TestDeleteParameters:
    def test_batch_delete(self, client: TestClient) -> None:
        _post(client, "PutParameter", {"Name": "/d1", "Value": "a"})
        _post(client, "PutParameter", {"Name": "/d2", "Value": "b"})
        result = _post(client, "DeleteParameters", {"Names": ["/d1", "/d2", "/d3"]})
        assert sorted(result["DeletedParameters"]) == ["/d1", "/d2"]
        assert result["InvalidParameters"] == ["/d3"]
