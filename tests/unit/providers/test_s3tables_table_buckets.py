"""Tests for S3 Tables table bucket operations."""

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


class TestListTableBuckets:
    def test_list_table_buckets_empty(self, client: TestClient) -> None:
        # Arrange
        # No buckets created

        # Act
        response = client.get("/table-buckets")

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        assert actual_body["tableBuckets"] == []

    def test_list_table_buckets_returns_created_buckets(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "listed-bucket"
        client.put("/table-buckets", json={"name": bucket_name})

        # Act
        response = client.get("/table-buckets")

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        actual_names = [b["name"] for b in actual_body["tableBuckets"]]
        assert bucket_name in actual_names

    def test_list_table_buckets_returns_multiple(self, client: TestClient) -> None:
        # Arrange
        bucket_name_a = "bucket-a"
        bucket_name_b = "bucket-b"
        client.put("/table-buckets", json={"name": bucket_name_a})
        client.put("/table-buckets", json={"name": bucket_name_b})

        # Act
        response = client.get("/table-buckets")

        # Assert
        expected_count = 2
        actual_body = response.json()
        actual_count = len(actual_body["tableBuckets"])
        assert actual_count == expected_count


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


class TestDeleteTableBucket:
    def test_delete_table_bucket_returns_204(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "del-bucket"
        client.put("/table-buckets", json={"name": bucket_name})

        # Act
        response = client.delete(f"/table-buckets/{bucket_name}")

        # Assert
        expected_status = 204
        actual_status = response.status_code
        assert actual_status == expected_status

    def test_delete_table_bucket_removes_from_list(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "del-listed-bucket"
        client.put("/table-buckets", json={"name": bucket_name})

        # Act
        client.delete(f"/table-buckets/{bucket_name}")

        # Assert
        list_response = client.get("/table-buckets")
        actual_body = list_response.json()
        actual_names = [b["name"] for b in actual_body["tableBuckets"]]
        assert bucket_name not in actual_names

    def test_delete_table_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "no-such-bucket"

        # Act
        response = client.delete(f"/table-buckets/{bucket_name}")

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert actual_body["__type"] == expected_error_type
