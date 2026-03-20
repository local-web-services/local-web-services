"""Tests for lws.providers.elasticsearch.routes -- CreateElasticsearchDomain."""

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


class TestCreateElasticsearchDomain:
    def test_create_domain(self, client: TestClient) -> None:
        # Arrange
        domain_name = "test-domain"
        expected_domain_name = domain_name

        # Act
        result = _post(client, "CreateElasticsearchDomain", {"DomainName": domain_name})

        # Assert
        actual_domain_name = result["DomainStatus"]["DomainName"]
        assert actual_domain_name == expected_domain_name, (
            f"Expected {expected_domain_name!r} but got {actual_domain_name!r}"
        )
        assert "ARN" in result["DomainStatus"], (
            f'Expected {"ARN"!r} to be in {result["DomainStatus"]!r}'
        )
        assert "Endpoint" in result["DomainStatus"], (
            f'Expected {"Endpoint"!r} to be in {result["DomainStatus"]!r}'
        )

    def test_create_domain_returns_domain_status_fields(self, client: TestClient) -> None:
        # Arrange
        domain_name = "fields-domain"
        expected_version = "7.10"

        # Act
        result = _post(client, "CreateElasticsearchDomain", {"DomainName": domain_name})

        # Assert
        status = result["DomainStatus"]
        actual_version = status["ElasticsearchVersion"]
        assert actual_version == expected_version, (
            f"Expected {expected_version!r} but got {actual_version!r}"
        )
        assert status["Created"] is True, "Expected value to be truthy"
        assert status["Processing"] is False, "Expected value to be truthy"
        assert status["Deleted"] is False, "Expected value to be truthy"
        assert "ElasticsearchClusterConfig" in status, (
            f'Expected {"ElasticsearchClusterConfig"!r} to be in {status!r}'
        )
        assert "DomainId" in status, f'Expected {"DomainId"!r} to be in {status!r}'

    def test_create_domain_with_custom_version(self, client: TestClient) -> None:
        # Arrange
        domain_name = "custom-ver-domain"
        expected_version = "6.8"

        # Act
        result = _post(
            client,
            "CreateElasticsearchDomain",
            {"DomainName": domain_name, "ElasticsearchVersion": expected_version},
        )

        # Assert
        actual_version = result["DomainStatus"]["ElasticsearchVersion"]
        assert actual_version == expected_version, (
            f"Expected {expected_version!r} but got {actual_version!r}"
        )

    def test_create_duplicate_domain_returns_error(self, client: TestClient) -> None:
        # Arrange
        domain_name = "dup-domain"
        expected_error_type = "ResourceAlreadyExistsException"
        _post(client, "CreateElasticsearchDomain", {"DomainName": domain_name})

        # Act
        result = _post(client, "CreateElasticsearchDomain", {"DomainName": domain_name})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type, (
            f"Expected {expected_error_type!r} but got {actual_error_type!r}"
        )

    def test_create_domain_without_name_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "ValidationException"

        # Act
        result = _post(client, "CreateElasticsearchDomain", {})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type, (
            f"Expected {expected_error_type!r} but got {actual_error_type!r}"
        )
