"""Unit tests: Service Catalog ProvisionProduct handler."""

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


class TestProvisionProduct:
    def test_provision_known_product_returns_succeeded(self) -> None:
        # Arrange
        app, _ = create_service_catalog_app()
        client = TestClient(app)

        # Act
        actual_status, actual_body = _sc_post(
            client,
            "ProvisionProduct",
            {"ProductId": _DEFAULT_PRODUCT_ID, "ProvisionedProductName": "test-pp"},
        )

        # Assert
        expected_status = 200
        assert actual_status == expected_status
        expected_record_status = "SUCCEEDED"
        actual_record_status = actual_body["RecordDetail"]["Status"]
        assert actual_record_status == expected_record_status

    def test_provision_creates_record_in_state(self) -> None:
        # Arrange
        app, state = create_service_catalog_app()
        client = TestClient(app)

        # Act
        _, actual_body = _sc_post(
            client,
            "ProvisionProduct",
            {"ProductId": _DEFAULT_PRODUCT_ID, "ProvisionedProductName": "test-pp"},
        )

        # Assert
        actual_record_id = actual_body["RecordDetail"]["RecordId"]
        expected_record_exists = True
        actual_record_exists = actual_record_id in state.records
        assert actual_record_exists == expected_record_exists

    def test_provision_unknown_product_returns_not_found(self) -> None:
        # Arrange
        app, _ = create_service_catalog_app()
        client = TestClient(app)

        # Act
        actual_status, actual_body = _sc_post(
            client,
            "ProvisionProduct",
            {"ProductId": "prod-missing", "ProvisionedProductName": "test-pp"},
        )

        # Assert
        expected_status = 400
        assert actual_status == expected_status
        expected_error_type = "ResourceNotFoundException"
        actual_error_type = actual_body["__type"]
        assert actual_error_type == expected_error_type
