"""Tests for S3 Tables table operations."""

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


class TestListTables:
    def test_list_tables_empty(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "empty-tbl-bucket"
        namespace_name = "empty-tbl-ns"
        _create_table_bucket(client, bucket_name)
        _create_namespace(client, bucket_name, namespace_name)

        # Act
        response = client.get(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables")

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        assert actual_body["tables"] == []

    def test_list_tables_returns_created(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "list-tbl-bucket"
        namespace_name = "list-tbl-ns"
        table_name = "listed-table"
        _create_table_bucket(client, bucket_name)
        _create_namespace(client, bucket_name, namespace_name)
        client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": "ICEBERG"},
        )

        # Act
        response = client.get(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables")

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        actual_names = [t["name"] for t in actual_body["tables"]]
        assert table_name in actual_names

    def test_list_tables_returns_multiple(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "multi-tbl-bucket"
        namespace_name = "multi-tbl-ns"
        table_name_a = "table-alpha"
        table_name_b = "table-beta"
        _create_table_bucket(client, bucket_name)
        _create_namespace(client, bucket_name, namespace_name)
        client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name_a, "format": "ICEBERG"},
        )
        client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name_b, "format": "ICEBERG"},
        )

        # Act
        response = client.get(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables")

        # Assert
        expected_count = 2
        actual_body = response.json()
        actual_count = len(actual_body["tables"])
        assert actual_count == expected_count

    def test_list_tables_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "no-bucket-list-tbl"
        namespace_name = "irrelevant-ns"

        # Act
        response = client.get(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables")

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status

    def test_list_tables_namespace_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "no-ns-list-tbl-bucket"
        namespace_name = "missing-ns"
        _create_table_bucket(client, bucket_name)

        # Act
        response = client.get(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables")

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status


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


class TestDeleteTable:
    def test_delete_table_returns_204(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "del-tbl-bucket"
        namespace_name = "del-tbl-ns"
        table_name = "del-table"
        _create_table_bucket(client, bucket_name)
        _create_namespace(client, bucket_name, namespace_name)
        client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": "ICEBERG"},
        )

        # Act
        response = client.delete(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Assert
        expected_status = 204
        actual_status = response.status_code
        assert actual_status == expected_status

    def test_delete_table_removes_from_list(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "del-tbl-list-bucket"
        namespace_name = "del-tbl-list-ns"
        table_name = "del-listed-table"
        _create_table_bucket(client, bucket_name)
        _create_namespace(client, bucket_name, namespace_name)
        client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": "ICEBERG"},
        )

        # Act
        client.delete(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Assert
        list_response = client.get(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables"
        )
        actual_body = list_response.json()
        actual_names = [t["name"] for t in actual_body["tables"]]
        assert table_name not in actual_names

    def test_delete_table_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "del-tbl-404-bucket"
        namespace_name = "del-tbl-404-ns"
        table_name = "ghost-table"
        _create_table_bucket(client, bucket_name)
        _create_namespace(client, bucket_name, namespace_name)

        # Act
        response = client.delete(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert actual_body["__type"] == expected_error_type

    def test_delete_table_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "no-bucket-del-tbl"
        namespace_name = "any-ns"
        table_name = "any-table"

        # Act
        response = client.delete(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status

    def test_delete_table_namespace_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "no-ns-del-tbl-bucket"
        namespace_name = "missing-ns"
        table_name = "missing-table"
        _create_table_bucket(client, bucket_name)

        # Act
        response = client.delete(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status
