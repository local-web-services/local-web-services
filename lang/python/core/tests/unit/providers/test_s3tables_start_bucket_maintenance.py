"""Tests for S3 Tables start_table_bucket_maintenance operation."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.s3tables.routes import create_s3tables_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_s3tables_app()
    return TestClient(app)


class TestStartTableBucketMaintenance:
    def test_start_bucket_maintenance_returns_204(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "bucket-maint-start"
        client.put("/buckets", json={"name": bucket_name})
        expected_status = 204

        # Act
        response = client.put(
            f"/buckets/{bucket_name}/maintenance/icebergCompaction",
            json={"value": {"status": "enabled"}},
        )

        # Assert
        actual_status = response.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_start_bucket_maintenance_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "ghost-bucket-maint"
        expected_status = 404

        # Act
        response = client.put(
            f"/buckets/{bucket_name}/maintenance/icebergCompaction",
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
