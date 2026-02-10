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


class TestTags:
    def test_add_and_list_tags(self, client: TestClient) -> None:
        _post(client, "PutParameter", {"Name": "/tagged", "Value": "v"})
        _post(
            client,
            "AddTagsToResource",
            {
                "ResourceType": "Parameter",
                "ResourceId": "/tagged",
                "Tags": [{"Key": "env", "Value": "dev"}],
            },
        )
        result = _post(
            client,
            "ListTagsForResource",
            {"ResourceType": "Parameter", "ResourceId": "/tagged"},
        )
        assert len(result["TagList"]) == 1
        assert result["TagList"][0]["Key"] == "env"

    def test_remove_tags(self, client: TestClient) -> None:
        _post(
            client,
            "PutParameter",
            {
                "Name": "/rt",
                "Value": "v",
                "Tags": [{"Key": "k1", "Value": "v1"}],
            },
        )
        _post(
            client,
            "RemoveTagsFromResource",
            {"ResourceType": "Parameter", "ResourceId": "/rt", "TagKeys": ["k1"]},
        )
        result = _post(
            client,
            "ListTagsForResource",
            {"ResourceType": "Parameter", "ResourceId": "/rt"},
        )
        assert result["TagList"] == []
