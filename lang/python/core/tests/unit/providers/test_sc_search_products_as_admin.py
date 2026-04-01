"""Unit tests: Service Catalog SearchProductsAsAdmin handler."""

from __future__ import annotations

import json

from fastapi.testclient import TestClient

from lws.providers.service_catalog._sc_state import _ScState
from lws.providers.service_catalog.routes import create_service_catalog_app


def _sc_post(client: TestClient, action: str, body: dict | None = None) -> tuple[int, dict]:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AWS_ServiceCatalog_20151201.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.status_code, resp.json()


class TestSearchProductsAsAdmin:
    def test_returns_pre_seeded_products(self) -> None:
        # Arrange
        app, _ = create_service_catalog_app()
        client = TestClient(app)

        # Act
        actual_status, actual_body = _sc_post(client, "SearchProductsAsAdmin")

        # Assert
        expected_status = 200
        assert actual_status == expected_status
        expected_min_count = 1
        actual_count = len(actual_body["ProductViewDetails"])
        assert actual_count >= expected_min_count

    def test_empty_catalogue_returns_empty_list(self) -> None:
        # Arrange
        state = _ScState()
        state.products.clear()
        app, _ = create_service_catalog_app(state=state)
        client = TestClient(app)

        # Act
        actual_status, actual_body = _sc_post(client, "SearchProductsAsAdmin")

        # Assert
        expected_status = 200
        assert actual_status == expected_status
        expected_product_count = 0
        actual_product_count = len(actual_body["ProductViewDetails"])
        assert actual_product_count == expected_product_count
