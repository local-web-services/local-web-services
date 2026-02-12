"""Tests for OpenSearch data-plane endpoint wiring."""

from __future__ import annotations

import json

from fastapi.testclient import TestClient

from lws.providers.opensearch.routes import create_opensearch_app


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonOpenSearchService.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestOpenSearchDataPlaneEndpoint:
    def test_with_data_plane_endpoint_uses_real_endpoint(self) -> None:
        # Arrange
        expected_endpoint = "localhost:9200"
        app = create_opensearch_app(data_plane_endpoint="localhost:9200")
        client = TestClient(app)

        # Act
        result = _post(
            client,
            "CreateDomain",
            {"DomainName": "test-domain"},
        )

        # Assert
        actual_endpoint = result["DomainStatus"]["Endpoint"]
        assert actual_endpoint == expected_endpoint

    def test_without_data_plane_endpoint_uses_synthetic_endpoint(self) -> None:
        # Arrange
        expected_suffix = "aoss.amazonaws.com"
        app = create_opensearch_app()
        client = TestClient(app)

        # Act
        result = _post(
            client,
            "CreateDomain",
            {"DomainName": "test-domain"},
        )

        # Assert
        actual_endpoint = result["DomainStatus"]["Endpoint"]
        assert expected_suffix in actual_endpoint
