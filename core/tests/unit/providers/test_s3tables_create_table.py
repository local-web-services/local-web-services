"""Tests for S3 Tables create table operation."""

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


class TestCreateTable:
    def test_create_table_returns_arn(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "tbl-bucket"
        namespace_name = "tbl-ns"
        table_name = "my-table"
        _create_table_bucket(client, bucket_name)
        _create_namespace(client, bucket_name, namespace_name)

        # Act
        response = client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": "ICEBERG"},
        )

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        assert "tableARN" in actual_body
        assert table_name in actual_body["tableARN"]

    def test_create_table_duplicate_returns_conflict(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "dup-tbl-bucket"
        namespace_name = "dup-tbl-ns"
        table_name = "dup-table"
        _create_table_bucket(client, bucket_name)
        _create_namespace(client, bucket_name, namespace_name)
        client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": "ICEBERG"},
        )

        # Act
        response = client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": "ICEBERG"},
        )

        # Assert
        expected_status = 409
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "ConflictException"
        assert actual_body["__type"] == expected_error_type

    def test_create_table_missing_name_returns_error(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "no-name-tbl-bucket"
        namespace_name = "no-name-tbl-ns"
        _create_table_bucket(client, bucket_name)
        _create_namespace(client, bucket_name, namespace_name)

        # Act
        response = client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"format": "ICEBERG"},
        )

        # Assert
        expected_status = 400
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "BadRequestException"
        assert actual_body["__type"] == expected_error_type

    def test_create_table_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "ghost-tbl-bucket"
        namespace_name = "ghost-tbl-ns"
        table_name = "orphan-table"

        # Act
        response = client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": "ICEBERG"},
        )

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert actual_body["__type"] == expected_error_type

    def test_create_table_namespace_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "ns-miss-tbl-bucket"
        namespace_name = "missing-ns"
        table_name = "orphan-ns-table"
        _create_table_bucket(client, bucket_name)

        # Act
        response = client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": "ICEBERG"},
        )

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert actual_body["__type"] == expected_error_type
