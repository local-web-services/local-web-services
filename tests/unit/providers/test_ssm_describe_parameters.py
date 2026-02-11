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


class TestDescribeParameters:
    def test_describe_all(self, client: TestClient) -> None:
        expected_name = "/desc"
        expected_description = "test param"
        _post(
            client,
            "PutParameter",
            {"Name": expected_name, "Value": "v", "Description": expected_description},
        )
        result = _post(client, "DescribeParameters", {})

        # Assert
        assert len(result["Parameters"]) >= 1
        param = result["Parameters"][0]
        assert param["Name"] == expected_name
        assert param["Description"] == expected_description
