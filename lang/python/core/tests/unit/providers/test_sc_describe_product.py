"""Unit tests: Service Catalog DescribeProduct handler."""

from __future__ import annotations

import json

from fastapi.testclient import TestClient

from lws.providers.service_catalog._sc_state import _DEFAULT_PRODUCT_ID
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


class TestDescribeProduct:
    def test_known_product_returns_summary(self) -> None:
        # Arrange
        app, _ = create_service_catalog_app()
        client = TestClient(app)

        # Act
        actual_status, actual_body = _sc_post(
            client, "DescribeProduct", {"Id": _DEFAULT_PRODUCT_ID}
        )

        # Assert
        expected_status = 200
        assert actual_status == expected_status
        expected_product_id = _DEFAULT_PRODUCT_ID
        actual_product_id = actual_body["ProductViewSummary"]["ProductId"]
        assert actual_product_id == expected_product_id

    def test_unknown_product_returns_not_found(self) -> None:
        # Arrange
        app, _ = create_service_catalog_app()
        client = TestClient(app)

        # Act
        actual_status, actual_body = _sc_post(client, "DescribeProduct", {"Id": "prod-missing"})

        # Assert
        expected_status = 400
        assert actual_status == expected_status
        expected_error_type = "ResourceNotFoundException"
        actual_error_type = actual_body["__type"]
        assert actual_error_type == expected_error_type
