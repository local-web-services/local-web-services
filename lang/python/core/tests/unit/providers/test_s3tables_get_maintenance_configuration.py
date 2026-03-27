"""Tests for S3 Tables get_table_maintenance_configuration operation."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.s3tables.routes import create_s3tables_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_s3tables_app()
    return TestClient(app)


def _setup_bucket_namespace_table(
    client: TestClient,
    bucket_name: str,
    namespace_name: str,
    table_name: str,
) -> None:
    client.put("/buckets", json={"name": bucket_name})
    client.put(f"/namespaces/{bucket_name}", json={"namespace": [namespace_name]})
    client.put(
        f"/tables/{bucket_name}/{namespace_name}",
        json={"name": table_name, "format": "ICEBERG"},
    )


class TestGetTableMaintenanceConfiguration:
    def test_get_maintenance_config_returns_stored_value(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "maint-get-bucket"
        namespace_name = "maint-get-ns"
        table_name = "maint-get-table"
        maintenance_type = "icebergCompaction"
        _setup_bucket_namespace_table(client, bucket_name, namespace_name, table_name)
        client.put(
            f"/tables/{bucket_name}/{namespace_name}/{table_name}/maintenance/{maintenance_type}",
            json={"value": {"status": "enabled"}},
        )
        expected_status = 200
        expected_type = maintenance_type

        # Act
        response = client.get(
            f"/tables/{bucket_name}/{namespace_name}/{table_name}/maintenance/{maintenance_type}"
        )

        # Assert
        actual_status = response.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_body = response.json()
        actual_type = actual_body.get("type")
        assert actual_type == expected_type, f"Expected {expected_type!r} but got {actual_type!r}"

    def test_get_maintenance_config_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "ghost-maint-get-bucket"
        namespace_name = "maint-ns"
        table_name = "maint-table"
        expected_status = 404

        # Act
        response = client.get(
            f"/tables/{bucket_name}/{namespace_name}/{table_name}/maintenance/icebergCompaction"
        )

        # Assert
        actual_status = response.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert (
            actual_body["__type"] == expected_error_type
        ), f'Expected {expected_error_type!r} but got {actual_body["__type"]!r}'

    def test_get_maintenance_config_table_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "maint-get-miss-bucket"
        namespace_name = "maint-get-miss-ns"
        table_name = "ghost-maint-table"
        client.put("/buckets", json={"name": bucket_name})
        client.put(f"/namespaces/{bucket_name}", json={"namespace": [namespace_name]})
        expected_status = 404

        # Act
        response = client.get(
            f"/tables/{bucket_name}/{namespace_name}/{table_name}/maintenance/icebergCompaction"
        )

        # Assert
        actual_status = response.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert (
            actual_body["__type"] == expected_error_type
        ), f'Expected {expected_error_type!r} but got {actual_body["__type"]!r}'
