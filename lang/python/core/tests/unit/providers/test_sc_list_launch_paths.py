"""Unit tests: Service Catalog ListLaunchPaths handler."""

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


class TestListLaunchPaths:
    def test_known_product_returns_launch_paths(self) -> None:
        # Arrange
        app, _ = create_service_catalog_app()
        client = TestClient(app)

        # Act
        actual_status, actual_body = _sc_post(
            client, "ListLaunchPaths", {"ProductId": _DEFAULT_PRODUCT_ID}
        )

        # Assert
        expected_status = 200
        assert actual_status == expected_status
        expected_min_paths = 1
        actual_path_count = len(actual_body["LaunchPathSummaries"])
        assert actual_path_count >= expected_min_paths

    def test_unknown_product_returns_not_found(self) -> None:
        # Arrange
        app, _ = create_service_catalog_app()
        client = TestClient(app)

        # Act
        actual_status, actual_body = _sc_post(
            client, "ListLaunchPaths", {"ProductId": "prod-missing"}
        )

        # Assert
        expected_status = 400
        assert actual_status == expected_status
        expected_error_type = "ResourceNotFoundException"
        actual_error_type = actual_body["__type"]
        assert actual_error_type == expected_error_type
