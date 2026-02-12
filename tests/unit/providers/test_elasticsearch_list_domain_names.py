"""Tests for lws.providers.elasticsearch.routes -- ListDomainNames."""

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


class TestListDomainNames:
    def test_list_empty(self, client: TestClient) -> None:
        # Arrange
        expected_count = 0

        # Act
        result = _post(client, "ListDomainNames")

        # Assert
        assert len(result["DomainNames"]) == expected_count

    def test_list_with_domains(self, client: TestClient) -> None:
        # Arrange
        domain_name_a = "list-a"
        domain_name_b = "list-b"
        expected_count = 2
        _post(client, "CreateElasticsearchDomain", {"DomainName": domain_name_a})
        _post(client, "CreateElasticsearchDomain", {"DomainName": domain_name_b})

        # Act
        result = _post(client, "ListDomainNames")

        # Assert
        assert len(result["DomainNames"]) == expected_count
        names = [d["DomainName"] for d in result["DomainNames"]]
        assert domain_name_a in names
        assert domain_name_b in names
