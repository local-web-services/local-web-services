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


class TestTags:
    def test_tag_and_untag(self, client: TestClient) -> None:
        _post(client, "CreateSecret", {"Name": "tagged"})
        _post(
            client,
            "TagResource",
            {
                "SecretId": "tagged",
                "Tags": [{"Key": "env", "Value": "dev"}],
            },
        )

        desc = _post(client, "DescribeSecret", {"SecretId": "tagged"})
        assert any(t["Key"] == "env" for t in desc.get("Tags", []))

        _post(
            client,
            "UntagResource",
            {"SecretId": "tagged", "TagKeys": ["env"]},
        )
        desc2 = _post(client, "DescribeSecret", {"SecretId": "tagged"})
        assert "Tags" not in desc2 or len(desc2.get("Tags", [])) == 0
