"""Tests for lws.providers.docdb.routes -- ListTagsForResource operation."""

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
