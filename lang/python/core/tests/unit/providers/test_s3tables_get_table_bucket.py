"""Tests for S3 Tables get table bucket operation."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.s3tables.routes import create_s3tables_app


@pytest.fixture()
def client() -> TestClient:
    app = create_s3tables_app()
    return TestClient(app)


class TestGetTableBucket:
    def test_get_table_bucket_returns_details(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "get-bucket"
        client.put("/table-buckets", json={"name": bucket_name})

        # Act
        response = client.get(f"/table-buckets/{bucket_name}")

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status, (
            f"Expected {expected_status!r} but got {actual_status!r}"
        )
        actual_body = response.json()
        actual_name = actual_body["name"]
        assert actual_name == bucket_name, f"Expected {bucket_name!r} but got {actual_name!r}"
        assert "tableBucketARN" in actual_body, (
            f'Expected {"tableBucketARN"!r} to be in {actual_body!r}'
        )
        assert "createdAt" in actual_body, f'Expected {"createdAt"!r} to be in {actual_body!r}'

    def test_get_table_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "nonexistent-bucket"

        # Act
        response = client.get(f"/table-buckets/{bucket_name}")

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status, (
            f"Expected {expected_status!r} but got {actual_status!r}"
        )
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert actual_body["__type"] == expected_error_type, (
            f'Expected {expected_error_type!r} but got {actual_body["__type"]!r}'
        )
