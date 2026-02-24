"""Tests for lws.providers.neptune.routes -- ListTagsForResource operation."""

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


class TestListTagsForResource:
    def test_list_tags_empty(self, client: TestClient) -> None:
        # Arrange
        cluster_id = "nep-tag-list"
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
        cluster_id = "nep-tag-init"
        expected_tag_key = "env"
        expected_tag_value = "prod"
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
