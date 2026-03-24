"""Tests for S3 Tables list table buckets operation."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.s3tables.routes import create_s3tables_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_s3tables_app()
    return TestClient(app)


class TestListTableBuckets:
    def test_list_table_buckets_empty(self, client: TestClient) -> None:
        # Arrange
        # No buckets created

        # Act
        response = client.get("/buckets")

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_body = response.json()
        assert (
            actual_body["tableBuckets"] == []
        ), f'Expected {[]!r} but got {actual_body["tableBuckets"]!r}'

    def test_list_table_buckets_returns_created_buckets(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "listed-bucket"
        client.put("/buckets", json={"name": bucket_name})

        # Act
        response = client.get("/buckets")

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_body = response.json()
        actual_names = [b["name"] for b in actual_body["tableBuckets"]]
        assert bucket_name in actual_names, f"Expected {bucket_name!r} to be in {actual_names!r}"

    def test_list_table_buckets_returns_multiple(self, client: TestClient) -> None:
        # Arrange
        bucket_name_a = "bucket-a"
        bucket_name_b = "bucket-b"
        client.put("/buckets", json={"name": bucket_name_a})
        client.put("/buckets", json={"name": bucket_name_b})

        # Act
        response = client.get("/buckets")

        # Assert
        expected_count = 2
        actual_body = response.json()
        actual_count = len(actual_body["tableBuckets"])
        assert (
            actual_count == expected_count
        ), f"Expected {expected_count!r} but got {actual_count!r}"
