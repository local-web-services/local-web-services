"""Tests for lws.providers.neptune.routes -- AddTagsToResource operation."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.neptune.routes import create_neptune_app


@pytest.fixture()
def client() -> TestClient:
    app = create_neptune_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonNeptune.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestAddTagsToResource:
    def test_add_tags_to_cluster(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "nep-tag-add"
        expected_tag_key = "team"
        expected_tag_value = "data"
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
        instance_id = "nep-tag-add-inst"
        expected_tag_key = "project"
        expected_tag_value = "graph"
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
