"""Tests for lws.providers.opensearch.routes -- DescribeDomains."""

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


class TestDescribeDomains:
    def test_describe_multiple_domains(self, client: TestClient) -> None:
        # Arrange
        domain_name_a = "batch-a"
        domain_name_b = "batch-b"
        expected_count = 2
        _post(client, "CreateDomain", {"DomainName": domain_name_a})
        _post(client, "CreateDomain", {"DomainName": domain_name_b})

        # Act
        result = _post(
            client,
            "DescribeDomains",
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
        _post(client, "CreateDomain", {"DomainName": domain_name})

        # Act
        result = _post(
            client,
            "DescribeDomains",
            {"DomainNames": [domain_name, "no-such-domain"]},
        )

        # Assert
        assert len(result["DomainStatusList"]) == expected_count
