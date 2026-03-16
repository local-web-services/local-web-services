"""Tests for S3 Tables delete namespace operation."""

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


class TestDeleteNamespace:
    def test_delete_namespace_returns_204(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "del-ns-bucket"
        namespace_name = "del-ns"
        _create_table_bucket(client, bucket_name)
        client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Act
        response = client.delete(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}")

        # Assert
        expected_status = 204
        actual_status = response.status_code
        assert actual_status == expected_status

    def test_delete_namespace_removes_from_list(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "del-ns-list-bucket"
        namespace_name = "del-listed-ns"
        _create_table_bucket(client, bucket_name)
        client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Act
        client.delete(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}")

        # Assert
        list_response = client.get(f"/table-buckets/{bucket_name}/namespaces")
        actual_body = list_response.json()
        actual_namespaces = [ns["namespace"] for ns in actual_body["namespaces"]]
        assert [namespace_name] not in actual_namespaces

    def test_delete_namespace_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "del-ns-404-bucket"
        namespace_name = "ghost-ns"
        _create_table_bucket(client, bucket_name)

        # Act
        response = client.delete(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}")

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert actual_body["__type"] == expected_error_type

    def test_delete_namespace_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "no-bucket-del-ns"
        namespace_name = "any-ns"

        # Act
        response = client.delete(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}")

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert actual_body["__type"] == expected_error_type
