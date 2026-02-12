"""Tests for S3 Tables create table bucket operation."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.s3tables.routes import create_s3tables_app


@pytest.fixture()
def client() -> TestClient:
    app = create_s3tables_app()
    return TestClient(app)


class TestCreateTableBucket:
    def test_create_table_bucket_returns_arn(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "my-test-bucket"

        # Act
        response = client.put("/table-buckets", json={"name": bucket_name})

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        assert "tableBucketARN" in actual_body
        assert bucket_name in actual_body["tableBucketARN"]

    def test_create_table_bucket_duplicate_returns_conflict(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "dup-bucket"
        client.put("/table-buckets", json={"name": bucket_name})

        # Act
        response = client.put("/table-buckets", json={"name": bucket_name})

        # Assert
        expected_status = 409
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "ConflictException"
        assert actual_body["__type"] == expected_error_type

    def test_create_table_bucket_missing_name_returns_error(self, client: TestClient) -> None:
        # Arrange
        # No name provided

        # Act
        response = client.put("/table-buckets", json={})

        # Assert
        expected_status = 400
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "BadRequestException"
        assert actual_body["__type"] == expected_error_type
