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
        resource_id = "/tagged"
        expected_tag_key = "env"
        _post(client, "PutParameter", {"Name": resource_id, "Value": "v"})
        _post(
            client,
            "AddTagsToResource",
            {
                "ResourceType": "Parameter",
                "ResourceId": resource_id,
                "Tags": [{"Key": expected_tag_key, "Value": "dev"}],
            },
        )
        result = _post(
            client,
            "ListTagsForResource",
            {"ResourceType": "Parameter", "ResourceId": resource_id},
        )

        # Assert
        expected_tag_count = 1
        assert len(result["TagList"]) == expected_tag_count
        assert result["TagList"][0]["Key"] == expected_tag_key

    def test_remove_tags(self, client: TestClient) -> None:
        resource_id = "/rt"
        tag_key = "k1"
        _post(
            client,
            "PutParameter",
            {
                "Name": resource_id,
                "Value": "v",
                "Tags": [{"Key": tag_key, "Value": "v1"}],
            },
        )
        _post(
            client,
            "RemoveTagsFromResource",
            {"ResourceType": "Parameter", "ResourceId": resource_id, "TagKeys": [tag_key]},
        )
        result = _post(
            client,
            "ListTagsForResource",
            {"ResourceType": "Parameter", "ResourceId": resource_id},
        )

        # Assert
        assert result["TagList"] == []
