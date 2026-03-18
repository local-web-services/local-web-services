"""Tests for lws.providers.elasticache.routes -- Tag operations."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.elasticache.routes import create_elasticache_app


@pytest.fixture()
def client() -> TestClient:
    app = create_elasticache_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonElastiCache.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestTags:
    def test_add_and_list_tags(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "tagged-cluster"
        expected_tag_key = "env"
        expected_tag_value = "dev"
        result = _post(client, "CreateCacheCluster", {"CacheClusterId": cluster_id})
        resource_arn = result["CacheCluster"]["ARN"]
        _post(
            client,
            "AddTagsToResource",
            {
                "ResourceName": resource_arn,
                "Tags": [{"Key": expected_tag_key, "Value": expected_tag_value}],
            },
        )

        # Act
        result = _post(client, "ListTagsForResource", {"ResourceName": resource_arn})

        # Assert
        expected_tag_count = 1
        actual_tag_count = len(result["TagList"])
        assert actual_tag_count == expected_tag_count
        actual_tag_key = result["TagList"][0]["Key"]
        actual_tag_value = result["TagList"][0]["Value"]
        assert actual_tag_key == expected_tag_key
        assert actual_tag_value == expected_tag_value

    def test_remove_tags(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "rm-tag-cluster"
        tag_key = "remove-me"
        create_result = _post(client, "CreateCacheCluster", {"CacheClusterId": cluster_id})
        resource_arn = create_result["CacheCluster"]["ARN"]
        _post(
            client,
            "AddTagsToResource",
            {
                "ResourceName": resource_arn,
                "Tags": [{"Key": tag_key, "Value": "val"}],
            },
        )
        _post(
            client,
            "RemoveTagsFromResource",
            {"ResourceName": resource_arn, "TagKeys": [tag_key]},
        )

        # Act
        result = _post(client, "ListTagsForResource", {"ResourceName": resource_arn})

        # Assert
        assert result["TagList"] == []

    def test_list_tags_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "CacheClusterNotFound"
        fake_arn = "arn:aws:elasticache:us-east-1:000000000000:cluster:nonexistent"

        # Act
        result = _post(client, "ListTagsForResource", {"ResourceName": fake_arn})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type

    def test_add_tags_to_nonexistent_resource(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "CacheClusterNotFound"
        fake_arn = "arn:aws:elasticache:us-east-1:000000000000:cluster:missing"

        # Act
        result = _post(
            client,
            "AddTagsToResource",
            {
                "ResourceName": fake_arn,
                "Tags": [{"Key": "k", "Value": "v"}],
            },
        )

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type
