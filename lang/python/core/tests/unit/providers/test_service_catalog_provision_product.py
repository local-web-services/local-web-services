"""Tests for Service Catalog ProvisionProduct handler."""

from __future__ import annotations

import json

from fastapi.testclient import TestClient

from lws.providers.service_catalog._sc_state import _DEFAULT_PRODUCT_ID
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


class TestProvisionProduct:
    def test_provisioning_existing_product_succeeds(self) -> None:
        # Arrange
        app, _ = create_service_catalog_app()
        client = TestClient(app)
        expected_status = 200

        # Act
        actual_status, actual_body = _sc_post(
            client,
            "ProvisionProduct",
            {"ProductId": _DEFAULT_PRODUCT_ID, "ProvisionedProductName": "pp-1"},
        )

        # Assert
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        expected_key = "RecordDetail"
        assert expected_key in actual_body, f"Expected {expected_key!r} in response body"

    def test_provisioning_nonexistent_product_returns_error(self) -> None:
        # Arrange
        app, _ = create_service_catalog_app()
        client = TestClient(app)
        expected_status = 400
        expected_error_type = "ResourceNotFoundException"

        # Act
        actual_status, actual_body = _sc_post(
            client,
            "ProvisionProduct",
            {"ProductId": "prod-nonexistent", "ProvisionedProductName": "pp-bad"},
        )

        # Assert
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_error_type = actual_body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
