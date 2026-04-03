"""Tests for Service Catalog SearchProductsAsAdmin handler."""

from __future__ import annotations

import json

from fastapi.testclient import TestClient

from lws.providers.service_catalog.routes import create_service_catalog_app

_TARGET_PREFIX = "AWS242ServiceCatalogService"


def _sc_post(client: TestClient, action: str, body: dict | None = None) -> tuple[int, dict]:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"{_TARGET_PREFIX}.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.status_code, resp.json()


class TestSearchProductsAsAdmin:
    def test_search_returns_seeded_product(self) -> None:
        # Arrange
        app, _ = create_service_catalog_app()
        client = TestClient(app)
        expected_status = 200
        expected_min_product_count = 1

        # Act
        actual_status, actual_body = _sc_post(client, "SearchProductsAsAdmin")

        # Assert
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_product_count = len(actual_body["ProductViewDetails"])
        assert actual_product_count >= expected_min_product_count, (
            f"Expected at least {expected_min_product_count!r} product "
            f"but got {actual_product_count!r}"
        )
