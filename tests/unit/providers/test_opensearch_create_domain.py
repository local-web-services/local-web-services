"""Tests for lws.providers.opensearch.routes -- CreateDomain."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.opensearch.routes import create_opensearch_app


@pytest.fixture()
def client() -> TestClient:
    app = create_opensearch_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"OpenSearchService_20210101.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestCreateDomain:
    def test_create_domain(self, client: TestClient) -> None:
        # Arrange
        domain_name = "test-domain"
        expected_domain_name = domain_name

        # Act
        result = _post(client, "CreateDomain", {"DomainName": domain_name})

        # Assert
        actual_domain_name = result["DomainStatus"]["DomainName"]
        assert actual_domain_name == expected_domain_name
        assert "ARN" in result["DomainStatus"]
        assert "Endpoint" in result["DomainStatus"]

    def test_create_domain_returns_domain_status_fields(self, client: TestClient) -> None:
        # Arrange
        domain_name = "fields-domain"
        expected_version = "OpenSearch_2.11"

        # Act
        result = _post(client, "CreateDomain", {"DomainName": domain_name})

        # Assert
        status = result["DomainStatus"]
        actual_version = status["EngineVersion"]
        assert actual_version == expected_version
        assert status["Created"] is True
        assert status["Processing"] is False
        assert status["Deleted"] is False
        assert "ClusterConfig" in status
        assert "DomainId" in status

    def test_create_domain_with_custom_engine_version(self, client: TestClient) -> None:
        # Arrange
        domain_name = "custom-ver-domain"
        expected_version = "OpenSearch_1.3"

        # Act
        result = _post(
            client,
            "CreateDomain",
            {"DomainName": domain_name, "EngineVersion": expected_version},
        )

        # Assert
        actual_version = result["DomainStatus"]["EngineVersion"]
        assert actual_version == expected_version

    def test_create_duplicate_domain_returns_error(self, client: TestClient) -> None:
        # Arrange
        domain_name = "dup-domain"
        expected_error_type = "ResourceAlreadyExistsException"
        _post(client, "CreateDomain", {"DomainName": domain_name})

        # Act
        result = _post(client, "CreateDomain", {"DomainName": domain_name})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type

    def test_create_domain_without_name_returns_error(self, client: TestClient) -> None:
        # Arrange
        expected_error_type = "ValidationException"

        # Act
        result = _post(client, "CreateDomain", {})

        # Assert
        actual_error_type = result["__type"]
        assert actual_error_type == expected_error_type
