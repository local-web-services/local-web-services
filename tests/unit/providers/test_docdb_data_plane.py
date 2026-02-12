"""Tests for DocumentDB data-plane endpoint wiring."""

from __future__ import annotations

import json

from fastapi.testclient import TestClient

from lws.providers.docdb.routes import create_docdb_app


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonRDSv19.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestDocDBDataPlaneEndpoint:
    def test_with_data_plane_endpoint_uses_real_endpoint(self) -> None:
        # Arrange
        expected_endpoint = "localhost:27017"
        app = create_docdb_app(data_plane_endpoint="localhost:27017")
        client = TestClient(app)

        # Act
        result = _post(
            client,
            "CreateDBCluster",
            {"DBClusterIdentifier": "test-cluster", "Engine": "docdb"},
        )

        # Assert
        actual_endpoint = result["DBCluster"]["Endpoint"]
        assert actual_endpoint == expected_endpoint

    def test_without_data_plane_endpoint_uses_synthetic_endpoint(self) -> None:
        # Arrange
        expected_suffix = "docdb.amazonaws.com"
        app = create_docdb_app()
        client = TestClient(app)

        # Act
        result = _post(
            client,
            "CreateDBCluster",
            {"DBClusterIdentifier": "test-cluster", "Engine": "docdb"},
        )

        # Assert
        actual_endpoint = result["DBCluster"]["Endpoint"]
        assert expected_suffix in actual_endpoint
