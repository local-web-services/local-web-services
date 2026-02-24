"""Tests for S3 Tables delete table operation."""

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
