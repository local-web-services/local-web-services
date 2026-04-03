"""Tests for Service Catalog DescribeProduct handler."""

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


class TestDescribeProduct:
    def test_describing_existing_product_succeeds(self) -> None:
        # Arrange
        app, _ = create_service_catalog_app()
        client = TestClient(app)
        expected_status = 200
        expected_product_id = _DEFAULT_PRODUCT_ID

        # Act
        actual_status, actual_body = _sc_post(
            client, "DescribeProduct", {"Id": _DEFAULT_PRODUCT_ID}
        )

        # Assert
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_product_id = actual_body["ProductViewSummary"]["ProductId"]
        assert (
            actual_product_id == expected_product_id
        ), f"Expected {expected_product_id!r} but got {actual_product_id!r}"

    def test_describing_nonexistent_product_returns_error(self) -> None:
        # Arrange
        app, _ = create_service_catalog_app()
        client = TestClient(app)
        expected_status = 400
        expected_error_type = "ResourceNotFoundException"

        # Act
        actual_status, actual_body = _sc_post(
            client, "DescribeProduct", {"Id": "prod-does-not-exist"}
        )

        # Assert
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_error_type = actual_body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
