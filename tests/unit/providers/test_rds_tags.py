"""Tests for RDS ListTagsForResource, AddTagsToResource, RemoveTagsFromResource."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.rds.routes import create_rds_app


@pytest.fixture()
def client() -> TestClient:
    app = create_rds_app()
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


def _create_instance_and_get_arn(client: TestClient, db_id: str) -> str:
    result = _post(client, "CreateDBInstance", {"DBInstanceIdentifier": db_id})
    return result["DBInstance"]["DBInstanceArn"]


class TestTags:
    def test_add_and_list_tags(self, client: TestClient) -> None:
        # Arrange
        db_id = "tag-instance"
        expected_tag_key = "env"
        expected_tag_value = "dev"
        arn = _create_instance_and_get_arn(client, db_id)
        _post(
            client,
            "AddTagsToResource",
            {
                "ResourceName": arn,
                "Tags": [{"Key": expected_tag_key, "Value": expected_tag_value}],
            },
        )

        # Act
        result = _post(client, "ListTagsForResource", {"ResourceName": arn})

        # Assert
        expected_tag_count = 1
        assert len(result["TagList"]) == expected_tag_count
        actual_tag_key = result["TagList"][0]["Key"]
        actual_tag_value = result["TagList"][0]["Value"]
        assert actual_tag_key == expected_tag_key
        assert actual_tag_value == expected_tag_value

    def test_remove_tags(self, client: TestClient) -> None:
        # Arrange
        db_id = "rm-tag-instance"
        tag_key = "remove-me"
        arn = _create_instance_and_get_arn(client, db_id)
        _post(
            client,
            "AddTagsToResource",
            {
                "ResourceName": arn,
                "Tags": [{"Key": tag_key, "Value": "val"}],
            },
        )
        _post(
            client,
            "RemoveTagsFromResource",
            {"ResourceName": arn, "TagKeys": [tag_key]},
        )

        # Act
        result = _post(client, "ListTagsForResource", {"ResourceName": arn})

        # Assert
        assert result["TagList"] == []

    def test_list_tags_for_missing_resource_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "DBInstanceNotFoundFault"
        fake_arn = "arn:aws:rds:us-east-1:000000000000:db:no-exist"

        # Act
        result = _post(client, "ListTagsForResource", {"ResourceName": fake_arn})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type

    def test_add_tags_to_cluster(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "tag-cluster"
        expected_tag_key = "team"
        expected_tag_value = "backend"
        cluster_result = _post(
            client,
            "CreateDBCluster",
            {"DBClusterIdentifier": cluster_id, "Engine": "postgres"},
        )
        arn = cluster_result["DBCluster"]["DBClusterArn"]
        _post(
            client,
            "AddTagsToResource",
            {
                "ResourceName": arn,
                "Tags": [{"Key": expected_tag_key, "Value": expected_tag_value}],
            },
        )

        # Act
        result = _post(client, "ListTagsForResource", {"ResourceName": arn})

        # Assert
        expected_tag_count = 1
        assert len(result["TagList"]) == expected_tag_count
        actual_tag_key = result["TagList"][0]["Key"]
        actual_tag_value = result["TagList"][0]["Value"]
        assert actual_tag_key == expected_tag_key
        assert actual_tag_value == expected_tag_value
