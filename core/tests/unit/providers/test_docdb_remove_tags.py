"""Tests for lws.providers.docdb.routes -- RemoveTagsFromResource operation."""

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
