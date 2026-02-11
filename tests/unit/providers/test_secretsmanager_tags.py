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
        secret_name = "tagged"
        tag_key = "env"
        _post(client, "CreateSecret", {"Name": secret_name})
        _post(
            client,
            "TagResource",
            {
                "SecretId": secret_name,
                "Tags": [{"Key": tag_key, "Value": "dev"}],
            },
        )

        # Assert - tag is present
        desc = _post(client, "DescribeSecret", {"SecretId": secret_name})
        assert any(t["Key"] == tag_key for t in desc.get("Tags", []))

        _post(
            client,
            "UntagResource",
            {"SecretId": secret_name, "TagKeys": [tag_key]},
        )

        # Assert - tag is removed
        desc2 = _post(client, "DescribeSecret", {"SecretId": secret_name})
        assert "Tags" not in desc2 or len(desc2.get("Tags", [])) == 0
