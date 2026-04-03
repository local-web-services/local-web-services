"""Integration tests for Service Catalog provision and describe operations."""

from __future__ import annotations

import json

import pytest
from starlette.testclient import TestClient

from lws.providers.service_catalog.routes import create_service_catalog_app

_TARGET_PREFIX = "AWS242ServiceCatalogService"


def _post_json(
    client: TestClient, action: str, body: dict, headers: dict | None = None
) -> tuple[int, dict]:
    all_headers = {
        "Content-Type": "application/x-amz-json-1.1",
        "X-Amz-Target": f"{_TARGET_PREFIX}.{action}",
    }
    if headers:
        all_headers.update(headers)
    resp = client.post("/", headers=all_headers, content=json.dumps(body))
    return resp.status_code, resp.json()


@pytest.fixture
def sc_client() -> TestClient:
    app, _ = create_service_catalog_app()
    return TestClient(app, raise_server_exceptions=False)


class TestScProvisionAndDescribe:
    def test_search_products_as_admin_returns_seeded_product(self, sc_client: TestClient) -> None:
        # Arrange
        expected_product_name = "e2e-test-product-1"

        # Act
        status, body = _post_json(sc_client, "SearchProductsAsAdmin", {})

        # Assert
        actual_product_names = [
            detail["ProductViewSummary"]["Name"] for detail in body.get("ProductViewDetails", [])
        ]
        assert status == 200, f"Expected 200, got {status}"
        assert (
            expected_product_name in actual_product_names
        ), f"Expected product {expected_product_name} in {actual_product_names}"

    def test_provision_product_creates_record(self, sc_client: TestClient) -> None:
        # Arrange
        expected_product_id = "prod-e2etest0"
        expected_status = "SUCCEEDED"

        # Act
        status, body = _post_json(
            sc_client,
            "ProvisionProduct",
            {
                "ProductId": expected_product_id,
                "ProvisioningArtifactId": "pa-e2etest00",
                "ProvisionedProductName": "inttest-pp",
            },
        )

        # Assert
        actual_record = body.get("RecordDetail", {})
        actual_record_id = actual_record.get("RecordId", "")
        actual_product_id = actual_record.get("ProductId", "")
        actual_status = actual_record.get("Status", "")
        assert status == 200, f"Expected 200, got {status}"
        assert actual_record_id != "", "RecordId should be non-empty"
        assert (
            actual_product_id == expected_product_id
        ), f"Expected product ID {expected_product_id}, got {actual_product_id}"
        assert (
            actual_status == expected_status
        ), f"Expected record status {expected_status}, got {actual_status}"

    def test_describe_record_returns_provisioned_record(self, sc_client: TestClient) -> None:
        # Arrange — provision first to get a record ID
        _, provision_body = _post_json(
            sc_client,
            "ProvisionProduct",
            {
                "ProductId": "prod-e2etest0",
                "ProvisioningArtifactId": "pa-e2etest00",
                "ProvisionedProductName": "inttest-describe",
            },
        )
        expected_record_id = provision_body["RecordDetail"]["RecordId"]

        # Act
        status, body = _post_json(
            sc_client,
            "DescribeRecord",
            {"Id": expected_record_id},
        )

        # Assert
        actual_record_id = body.get("RecordDetail", {}).get("RecordId", "")
        assert status == 200, f"Expected 200, got {status}"
        assert (
            actual_record_id == expected_record_id
        ), f"Expected record ID {expected_record_id}, got {actual_record_id}"
