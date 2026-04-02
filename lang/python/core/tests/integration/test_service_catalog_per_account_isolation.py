"""Integration tests: Service Catalog per-account state isolation."""

from __future__ import annotations

import json

from starlette.testclient import TestClient

from lws.providers._shared.per_account_state import PerAccountStateRegistry
from lws.providers.service_catalog._sc_state import _DEFAULT_PRODUCT_ID, _ScState
from lws.providers.service_catalog.routes import create_service_catalog_app

_TOKEN_A = "lws-acct-111111111111-test-uuid"
_TOKEN_B = "lws-acct-222222222222-test-uuid"


def _sc_post(
    client: TestClient, action: str, body: dict, token: str | None = None
) -> tuple[int, dict]:
    headers: dict = {
        "Content-Type": "application/x-amz-json-1.1",
        "X-Amz-Target": f"AWS_ServiceCatalog_20151201.{action}",
    }
    if token:
        headers["X-Amz-Security-Token"] = token
    resp = client.post("/", headers=headers, content=json.dumps(body))
    return resp.status_code, resp.json()


class TestServiceCatalogPerAccountIsolation:
    def test_record_in_account_a_not_visible_in_account_b(self) -> None:
        # Arrange
        registry = PerAccountStateRegistry(_ScState)
        app, _ = create_service_catalog_app(registry=registry)
        client = TestClient(app, raise_server_exceptions=False)
        _, provision_body = _sc_post(
            client,
            "ProvisionProduct",
            {"ProductId": _DEFAULT_PRODUCT_ID, "ProvisionedProductName": "e2e-test-pp"},
            _TOKEN_A,
        )
        record_id = provision_body["RecordDetail"]["RecordId"]

        # Act
        actual_status, actual_body = _sc_post(client, "DescribeRecord", {"Id": record_id}, _TOKEN_B)

        # Assert
        expected_status = 400
        assert actual_status == expected_status
        expected_error_type = "ResourceNotFoundException"
        actual_error_type = actual_body["__type"]
        assert actual_error_type == expected_error_type

    def test_record_in_account_a_visible_within_same_account(self) -> None:
        # Arrange
        registry = PerAccountStateRegistry(_ScState)
        app, _ = create_service_catalog_app(registry=registry)
        client = TestClient(app, raise_server_exceptions=False)
        _, provision_body = _sc_post(
            client,
            "ProvisionProduct",
            {"ProductId": _DEFAULT_PRODUCT_ID, "ProvisionedProductName": "e2e-test-pp"},
            _TOKEN_A,
        )
        record_id = provision_body["RecordDetail"]["RecordId"]

        # Act
        actual_status, actual_body = _sc_post(client, "DescribeRecord", {"Id": record_id}, _TOKEN_A)

        # Assert
        expected_status = 200
        assert actual_status == expected_status
        expected_record_status = "SUCCEEDED"
        actual_record_status = actual_body["RecordDetail"]["Status"]
        assert actual_record_status == expected_record_status
