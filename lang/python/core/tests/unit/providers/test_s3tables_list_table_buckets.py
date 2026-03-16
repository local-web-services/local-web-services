"""Tests for S3 Tables list table buckets operation."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.s3tables.routes import create_s3tables_app


@pytest.fixture()
def client() -> TestClient:
    app = create_s3tables_app()
    return TestClient(app)


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
