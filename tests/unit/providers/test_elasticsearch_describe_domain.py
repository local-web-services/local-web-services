"""Tests for lws.providers.elasticsearch.routes -- DescribeElasticsearchDomain(s)."""

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


class TestDescribeElasticsearchDomain:
    def test_describe_existing_domain(self, client: TestClient) -> None:
        # Arrange
        domain_name = "desc-domain"
        expected_domain_name = domain_name
        _post(client, "CreateElasticsearchDomain", {"DomainName": domain_name})

        # Act
        result = _post(client, "DescribeElasticsearchDomain", {"DomainName": domain_name})

        # Assert
        actual_domain_name = result["DomainStatus"]["DomainName"]
        assert actual_domain_name == expected_domain_name

    def test_describe_nonexistent_domain_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "ResourceNotFoundException"

        # Act
        result = _post(client, "DescribeElasticsearchDomain", {"DomainName": "missing"})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type


class TestDescribeElasticsearchDomains:
    def test_describe_multiple_domains(self, client: TestClient) -> None:
        # Arrange
        domain_name_a = "batch-a"
        domain_name_b = "batch-b"
        expected_count = 2
        _post(client, "CreateElasticsearchDomain", {"DomainName": domain_name_a})
        _post(client, "CreateElasticsearchDomain", {"DomainName": domain_name_b})

        # Act
        result = _post(
            client,
            "DescribeElasticsearchDomains",
            {"DomainNames": [domain_name_a, domain_name_b]},
        )

        # Assert
        assert len(result["DomainStatusList"]) == expected_count
        names = [d["DomainName"] for d in result["DomainStatusList"]]
        assert domain_name_a in names
        assert domain_name_b in names

    def test_describe_batch_skips_missing(self, client: TestClient) -> None:
        # Arrange
        domain_name = "batch-exists"
        expected_count = 1
        _post(client, "CreateElasticsearchDomain", {"DomainName": domain_name})

        # Act
        result = _post(
            client,
            "DescribeElasticsearchDomains",
            {"DomainNames": [domain_name, "no-such-domain"]},
        )

        # Assert
        assert len(result["DomainStatusList"]) == expected_count
