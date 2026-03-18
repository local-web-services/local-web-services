"""Tests for S3 Tables get namespace operation."""

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


class TestGetNamespace:
    def test_get_namespace_returns_details(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "get-ns-bucket"
        namespace_name = "get-ns"
        _create_table_bucket(client, bucket_name)
        client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Act
        response = client.get(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}")

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        actual_namespace = actual_body["namespace"]
        assert actual_namespace == [namespace_name]
        assert "tableBucketARN" in actual_body
        assert "createdAt" in actual_body

    def test_get_namespace_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "get-ns-miss-bucket"
        namespace_name = "missing-ns"
        _create_table_bucket(client, bucket_name)

        # Act
        response = client.get(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}")

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert actual_body["__type"] == expected_error_type

    def test_get_namespace_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "no-bucket-for-ns"
        namespace_name = "irrelevant-ns"

        # Act
        response = client.get(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}")

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert actual_body["__type"] == expected_error_type
