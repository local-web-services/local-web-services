"""Tests for S3 Tables delete table bucket operation."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.s3tables.routes import create_s3tables_app


@pytest.fixture()
def client() -> TestClient:
    app = create_s3tables_app()
    return TestClient(app)


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
        assert actual_status == expected_status, (
            f"Expected {expected_status!r} but got {actual_status!r}"
        )

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
        assert bucket_name not in actual_names, (
            f"Expected {bucket_name!r} to not be in {actual_names!r}"
        )

    def test_delete_table_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "no-such-bucket"

        # Act
        response = client.delete(f"/table-buckets/{bucket_name}")

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
