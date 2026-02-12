"""Tests for Elasticsearch data-plane endpoint wiring."""

from __future__ import annotations

import json

from fastapi.testclient import TestClient

from lws.providers.elasticsearch.routes import create_elasticsearch_app


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonElasticsearchService.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestElasticsearchDataPlaneEndpoint:
    def test_with_data_plane_endpoint_uses_real_endpoint(self) -> None:
        # Arrange
        expected_endpoint = "localhost:9200"
        app = create_elasticsearch_app(data_plane_endpoint="localhost:9200")
        client = TestClient(app)

        # Act
        result = _post(
            client,
            "CreateElasticsearchDomain",
            {"DomainName": "test-domain"},
        )

        # Assert
        actual_endpoint = result["DomainStatus"]["Endpoint"]
        assert actual_endpoint == expected_endpoint

    def test_without_data_plane_endpoint_uses_synthetic_endpoint(self) -> None:
        # Arrange
        expected_suffix = "es.amazonaws.com"
        app = create_elasticsearch_app()
        client = TestClient(app)

        # Act
        result = _post(
            client,
            "CreateElasticsearchDomain",
            {"DomainName": "test-domain"},
        )

        # Assert
        actual_endpoint = result["DomainStatus"]["Endpoint"]
        assert expected_suffix in actual_endpoint
