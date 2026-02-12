"""Tests for lws.providers.elasticsearch.routes -- AddTags, ListTags, RemoveTags."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.elasticsearch.routes import create_elasticsearch_app


@pytest.fixture()
def client() -> TestClient:
    app = create_elasticsearch_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"ElasticsearchService_20150101.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


def _create_domain_and_get_arn(client: TestClient, domain_name: str) -> str:
    result = _post(client, "CreateElasticsearchDomain", {"DomainName": domain_name})
    return result["DomainStatus"]["ARN"]


class TestTags:
    def test_add_and_list_tags(self, client: TestClient) -> None:
        # Arrange
        domain_name = "tag-domain"
        expected_tag_key = "env"
        expected_tag_value = "dev"
        arn = _create_domain_and_get_arn(client, domain_name)
        _post(
            client,
            "AddTags",
            {
                "ARN": arn,
                "TagList": [{"Key": expected_tag_key, "Value": expected_tag_value}],
            },
        )

        # Act
        result = _post(client, "ListTags", {"ARN": arn})

        # Assert
        expected_tag_count = 1
        assert len(result["TagList"]) == expected_tag_count
        actual_tag_key = result["TagList"][0]["Key"]
        actual_tag_value = result["TagList"][0]["Value"]
        assert actual_tag_key == expected_tag_key
        assert actual_tag_value == expected_tag_value

    def test_remove_tags(self, client: TestClient) -> None:
        # Arrange
        domain_name = "rm-tag-domain"
        tag_key = "remove-me"
        arn = _create_domain_and_get_arn(client, domain_name)
        _post(
            client,
            "AddTags",
            {
                "ARN": arn,
                "TagList": [{"Key": tag_key, "Value": "val"}],
            },
        )
        _post(client, "RemoveTags", {"ARN": arn, "TagKeys": [tag_key]})

        # Act
        result = _post(client, "ListTags", {"ARN": arn})

        # Assert
        assert result["TagList"] == []

    def test_list_tags_for_missing_domain_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "ResourceNotFoundException"
        fake_arn = "arn:aws:es:us-east-1:000000000000:domain/no-exist"

        # Act
        result = _post(client, "ListTags", {"ARN": fake_arn})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type
