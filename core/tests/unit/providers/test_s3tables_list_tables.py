"""Tests for S3 Tables list tables operation."""

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
