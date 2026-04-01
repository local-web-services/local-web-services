"""Tests for S3 Tables put_table_maintenance_configuration operation."""

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
    bucket_name: str = "maint-bucket",
    namespace_name: str = "maint-ns",
    table_name: str = "maint-table",
) -> None:
    client.put("/buckets", json={"name": bucket_name})
    client.put(f"/namespaces/{bucket_name}", json={"namespace": [namespace_name]})
    client.put(
        f"/tables/{bucket_name}/{namespace_name}",
        json={"name": table_name, "format": "ICEBERG"},
    )


class TestPutTableMaintenanceConfiguration:
    def test_put_maintenance_config_returns_204(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "maint-put-bucket"
        namespace_name = "maint-put-ns"
        table_name = "maint-put-table"
        _setup_bucket_namespace_table(client, bucket_name, namespace_name, table_name)
        expected_status = 204

        # Act
        response = client.put(
            f"/tables/{bucket_name}/{namespace_name}/{table_name}/maintenance/icebergCompaction",
            json={"value": {"status": "enabled"}},
        )

        # Assert
        actual_status = response.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_put_maintenance_config_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "ghost-maint-bucket"
        namespace_name = "maint-ns"
        table_name = "maint-table"
        expected_status = 404

        # Act
        response = client.put(
            f"/tables/{bucket_name}/{namespace_name}/{table_name}/maintenance/icebergCompaction",
            json={"value": {"status": "enabled"}},
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

    def test_put_maintenance_config_table_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "maint-put-miss-bucket"
        namespace_name = "maint-put-miss-ns"
        table_name = "ghost-table"
        client.put("/buckets", json={"name": bucket_name})
        client.put(f"/namespaces/{bucket_name}", json={"namespace": [namespace_name]})
        expected_status = 404

        # Act
        response = client.put(
            f"/tables/{bucket_name}/{namespace_name}/{table_name}/maintenance/icebergCompaction",
            json={"value": {"status": "enabled"}},
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
