"""Integration tests: Service Catalog DescribeRecord."""

from __future__ import annotations

import json

from starlette.testclient import TestClient

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


class TestServiceCatalogDescribeRecord:
    def test_describe_record_after_provision_returns_succeeded(self) -> None:
        # Arrange
        app, _ = create_service_catalog_app()
        client = TestClient(app, raise_server_exceptions=False)
        _, provision_body = _sc_post(
            client,
            "ProvisionProduct",
            {"ProductId": _DEFAULT_PRODUCT_ID, "ProvisionedProductName": "e2e-test-pp"},
        )
        record_id = provision_body["RecordDetail"]["RecordId"]

        # Act
        actual_status, actual_body = _sc_post(client, "DescribeRecord", {"Id": record_id})

        # Assert
        expected_status = 200
        assert actual_status == expected_status
        expected_record_status = "SUCCEEDED"
        actual_record_status = actual_body["RecordDetail"]["Status"]
        assert actual_record_status == expected_record_status

    def test_describe_unknown_record_returns_error(self) -> None:
        # Arrange
        app, _ = create_service_catalog_app()
        client = TestClient(app, raise_server_exceptions=False)

        # Act
        actual_status, actual_body = _sc_post(client, "DescribeRecord", {"Id": "rec-missing"})

        # Assert
        expected_status = 400
        assert actual_status == expected_status
        expected_error_type = "ResourceNotFoundException"
        actual_error_type = actual_body["__type"]
        assert actual_error_type == expected_error_type
