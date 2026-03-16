"""Tests for S3 Tables get table operation."""

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


def _create_namespace(client: TestClient, bucket_name: str, namespace_name: str) -> None:
    client.put(
        f"/table-buckets/{bucket_name}/namespaces",
        json={"namespace": [namespace_name]},
    )


class TestGetTable:
    def test_get_table_returns_details(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "get-tbl-bucket"
        namespace_name = "get-tbl-ns"
        table_name = "get-table"
        expected_format = "ICEBERG"
        _create_table_bucket(client, bucket_name)
        _create_namespace(client, bucket_name, namespace_name)
        client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": expected_format},
        )

        # Act
        response = client.get(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        actual_name = actual_body["name"]
        assert actual_name == table_name
        actual_format = actual_body["format"]
        assert actual_format == expected_format
        assert "tableARN" in actual_body
        assert "tableBucketARN" in actual_body
        assert "createdAt" in actual_body
        actual_namespace = actual_body["namespace"]
        assert actual_namespace == [namespace_name]

    def test_get_table_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "get-tbl-miss-bucket"
        namespace_name = "get-tbl-miss-ns"
        table_name = "missing-table"
        _create_table_bucket(client, bucket_name)
        _create_namespace(client, bucket_name, namespace_name)

        # Act
        response = client.get(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert actual_body["__type"] == expected_error_type

    def test_get_table_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "no-bucket-get-tbl"
        namespace_name = "irrelevant-ns"
        table_name = "irrelevant-table"

        # Act
        response = client.get(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status

    def test_get_table_namespace_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "no-ns-get-tbl-bucket"
        namespace_name = "ghost-ns"
        table_name = "ghost-table"
        _create_table_bucket(client, bucket_name)

        # Act
        response = client.get(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status
