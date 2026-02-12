"""Tests for lws.providers.docdb.routes -- Tag operations."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.docdb.routes import create_docdb_app


@pytest.fixture()
def client() -> TestClient:
    app = create_docdb_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonRDSv19.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestListTagsForResource:
    def test_list_tags_empty(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "tag-list-cluster"
        create_result = _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id})
        cluster_arn = create_result["DBCluster"]["DBClusterArn"]

        # Act
        result = _post(client, "ListTagsForResource", {"ResourceName": cluster_arn})

        # Assert
        expected_count = 0
        actual_count = len(result["TagList"])
        assert actual_count == expected_count

    def test_list_tags_with_initial_tags(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "tag-init-cluster"
        expected_tag_key = "env"
        expected_tag_value = "dev"
        create_result = _post(
            client,
            "CreateDBCluster",
            {
                "DBClusterIdentifier": cluster_id,
                "Tags": [{"Key": expected_tag_key, "Value": expected_tag_value}],
            },
        )
        cluster_arn = create_result["DBCluster"]["DBClusterArn"]

        # Act
        result = _post(client, "ListTagsForResource", {"ResourceName": cluster_arn})

        # Assert
        expected_count = 1
        actual_count = len(result["TagList"])
        assert actual_count == expected_count
        actual_key = result["TagList"][0]["Key"]
        actual_value = result["TagList"][0]["Value"]
        assert actual_key == expected_tag_key
        assert actual_value == expected_tag_value


class TestAddTagsToResource:
    def test_add_tags(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "tag-add-cluster"
        expected_tag_key = "team"
        expected_tag_value = "backend"
        create_result = _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id})
        cluster_arn = create_result["DBCluster"]["DBClusterArn"]

        # Act
        _post(
            client,
            "AddTagsToResource",
            {
                "ResourceName": cluster_arn,
                "Tags": [{"Key": expected_tag_key, "Value": expected_tag_value}],
            },
        )

        # Assert
        result = _post(client, "ListTagsForResource", {"ResourceName": cluster_arn})
        expected_count = 1
        actual_count = len(result["TagList"])
        assert actual_count == expected_count
        actual_key = result["TagList"][0]["Key"]
        actual_value = result["TagList"][0]["Value"]
        assert actual_key == expected_tag_key
        assert actual_value == expected_tag_value

    def test_add_tags_to_instance(self, client: TestClient) -> None:
        # Arrange
        instance_id = "tag-add-inst"
        expected_tag_key = "project"
        expected_tag_value = "alpha"
        create_result = _post(client, "CreateDBInstance", {"DBInstanceIdentifier": instance_id})
        instance_arn = create_result["DBInstance"]["DBInstanceArn"]

        # Act
        _post(
            client,
            "AddTagsToResource",
            {
                "ResourceName": instance_arn,
                "Tags": [{"Key": expected_tag_key, "Value": expected_tag_value}],
            },
        )

        # Assert
        result = _post(client, "ListTagsForResource", {"ResourceName": instance_arn})
        expected_count = 1
        actual_count = len(result["TagList"])
        assert actual_count == expected_count
        actual_key = result["TagList"][0]["Key"]
        assert actual_key == expected_tag_key


class TestRemoveTagsFromResource:
    def test_remove_tags(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "tag-rm-cluster"
        tag_key = "removable"
        create_result = _post(
            client,
            "CreateDBCluster",
            {
                "DBClusterIdentifier": cluster_id,
                "Tags": [{"Key": tag_key, "Value": "yes"}],
            },
        )
        cluster_arn = create_result["DBCluster"]["DBClusterArn"]

        # Act
        _post(
            client,
            "RemoveTagsFromResource",
            {"ResourceName": cluster_arn, "TagKeys": [tag_key]},
        )

        # Assert
        result = _post(client, "ListTagsForResource", {"ResourceName": cluster_arn})
        assert result["TagList"] == []
