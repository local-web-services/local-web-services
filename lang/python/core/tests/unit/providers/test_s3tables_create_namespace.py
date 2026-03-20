"""Tests for S3 Tables create namespace operation."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.s3tables.routes import create_s3tables_app


@pytest.fixture()
def client() -> TestClient:
    app = create_s3tables_app()
    return TestClient(app)


def _create_table_bucket(client: TestClient, name: str) -> None:
    client.put("/table-buckets", json={"name": name})


class TestCreateNamespace:
    def test_create_namespace_returns_info(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "ns-bucket"
        namespace_name = "my-namespace"
        _create_table_bucket(client, bucket_name)

        # Act
        response = client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status, (
            f"Expected {expected_status!r} but got {actual_status!r}"
        )
        actual_body = response.json()
        actual_namespace = actual_body["namespace"]
        assert actual_namespace == [namespace_name], (
            f"Expected {[namespace_name]!r} but got {actual_namespace!r}"
        )
        assert "tableBucketARN" in actual_body, (
            f'Expected {"tableBucketARN"!r} to be in {actual_body!r}'
        )

    def test_create_namespace_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "nonexistent-bucket"
        namespace_name = "orphan-ns"

        # Act
        response = client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

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

    def test_create_namespace_duplicate_returns_conflict(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "dup-ns-bucket"
        namespace_name = "dup-ns"
        _create_table_bucket(client, bucket_name)
        client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Act
        response = client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Assert
        expected_status = 409
        actual_status = response.status_code
        assert actual_status == expected_status, (
            f"Expected {expected_status!r} but got {actual_status!r}"
        )
        actual_body = response.json()
        expected_error_type = "ConflictException"
        assert actual_body["__type"] == expected_error_type, (
            f'Expected {expected_error_type!r} but got {actual_body["__type"]!r}'
        )

    def test_create_namespace_missing_namespace_returns_error(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "empty-ns-bucket"
        _create_table_bucket(client, bucket_name)

        # Act
        response = client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={},
        )

        # Assert
        expected_status = 400
        actual_status = response.status_code
        assert actual_status == expected_status, (
            f"Expected {expected_status!r} but got {actual_status!r}"
        )
        actual_body = response.json()
        expected_error_type = "BadRequestException"
        assert actual_body["__type"] == expected_error_type, (
            f'Expected {expected_error_type!r} but got {actual_body["__type"]!r}'
        )
