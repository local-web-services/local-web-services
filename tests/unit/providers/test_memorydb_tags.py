"""Tests for lws.providers.memorydb.routes -- Tag operations."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.memorydb.routes import create_memorydb_app


@pytest.fixture()
def client() -> TestClient:
    app = create_memorydb_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonMemoryDB.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestTags:
    def test_tag_and_list_tags(self, client: TestClient) -> None:
        # Arrange
        cluster_name = "tagged-memorydb"
        expected_tag_key = "env"
        expected_tag_value = "staging"
        result = _post(client, "CreateCluster", {"ClusterName": cluster_name})
        resource_arn = result["Cluster"]["ARN"]
        _post(
            client,
            "TagResource",
            {
                "ResourceArn": resource_arn,
                "Tags": [{"Key": expected_tag_key, "Value": expected_tag_value}],
            },
        )

        # Act
        result = _post(client, "ListTags", {"ResourceArn": resource_arn})

        # Assert
        expected_tag_count = 1
        actual_tag_count = len(result["TagList"])
        assert actual_tag_count == expected_tag_count
        actual_tag_key = result["TagList"][0]["Key"]
        actual_tag_value = result["TagList"][0]["Value"]
        assert actual_tag_key == expected_tag_key
        assert actual_tag_value == expected_tag_value

    def test_untag_resource(self, client: TestClient) -> None:
        # Arrange
        cluster_name = "untag-memorydb"
        tag_key = "remove-me"
        create_result = _post(client, "CreateCluster", {"ClusterName": cluster_name})
        resource_arn = create_result["Cluster"]["ARN"]
        _post(
            client,
            "TagResource",
            {
                "ResourceArn": resource_arn,
                "Tags": [{"Key": tag_key, "Value": "val"}],
            },
        )
        _post(
            client,
            "UntagResource",
            {"ResourceArn": resource_arn, "TagKeys": [tag_key]},
        )

        # Act
        result = _post(client, "ListTags", {"ResourceArn": resource_arn})

        # Assert
        assert result["TagList"] == []

    def test_list_tags_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "ClusterNotFoundFault"
        fake_arn = "arn:aws:memorydb:us-east-1:000000000000:cluster/nonexistent"

        # Act
        result = _post(client, "ListTags", {"ResourceArn": fake_arn})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type

    def test_tag_nonexistent_resource(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "ClusterNotFoundFault"
        fake_arn = "arn:aws:memorydb:us-east-1:000000000000:cluster/missing"

        # Act
        result = _post(
            client,
            "TagResource",
            {
                "ResourceArn": fake_arn,
                "Tags": [{"Key": "k", "Value": "v"}],
            },
        )

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type
