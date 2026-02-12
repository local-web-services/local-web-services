"""Tests for OpenSearch per-resource container wiring."""

from __future__ import annotations

import json
from unittest.mock import AsyncMock

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
    def test_with_container_manager_uses_real_endpoint(self) -> None:
        # Arrange
        expected_endpoint = "localhost:9200"
        mock_cm = AsyncMock()
        mock_cm.start_container.return_value = expected_endpoint
        app = create_opensearch_app(container_manager=mock_cm)
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
        mock_cm.start_container.assert_called_once_with("test-domain")

    def test_without_container_manager_uses_synthetic_endpoint(self) -> None:
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

    def test_delete_domain_stops_container(self) -> None:
        # Arrange
        mock_cm = AsyncMock()
        mock_cm.start_container.return_value = "localhost:9200"
        app = create_opensearch_app(container_manager=mock_cm)
        client = TestClient(app)
        _post(client, "CreateDomain", {"DomainName": "test-domain"})

        # Act
        _post(client, "DeleteDomain", {"DomainName": "test-domain"})

        # Assert
        mock_cm.stop_container.assert_called_once_with("test-domain")
