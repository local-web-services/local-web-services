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
        assert actual_status == expected_status
        actual_body = response.json()
        actual_name = actual_body["name"]
        assert actual_name == bucket_name
        assert "tableBucketARN" in actual_body
        assert "createdAt" in actual_body

    def test_get_table_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "nonexistent-bucket"

        # Act
        response = client.get(f"/table-buckets/{bucket_name}")

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert actual_body["__type"] == expected_error_type
