"""Tests for lws.providers.opensearch.routes -- ListDomainNames."""

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
        _post(client, "CreateDomain", {"DomainName": domain_name_a})
        _post(client, "CreateDomain", {"DomainName": domain_name_b})

        # Act
        result = _post(client, "ListDomainNames")

        # Assert
        assert len(result["DomainNames"]) == expected_count
        names = [d["DomainName"] for d in result["DomainNames"]]
        assert domain_name_a in names
        assert domain_name_b in names
