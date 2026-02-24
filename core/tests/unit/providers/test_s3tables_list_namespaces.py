"""Tests for S3 Tables list namespaces operation."""

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


class TestListNamespaces:
    def test_list_namespaces_empty(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "empty-list-ns-bucket"
        _create_table_bucket(client, bucket_name)

        # Act
        response = client.get(f"/table-buckets/{bucket_name}/namespaces")

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        assert actual_body["namespaces"] == []

    def test_list_namespaces_returns_created(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "list-ns-bucket"
        namespace_name = "listed-ns"
        _create_table_bucket(client, bucket_name)
        client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Act
        response = client.get(f"/table-buckets/{bucket_name}/namespaces")

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        actual_namespaces = [ns["namespace"] for ns in actual_body["namespaces"]]
        assert [namespace_name] in actual_namespaces

    def test_list_namespaces_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "no-such-ns-bucket"

        # Act
        response = client.get(f"/table-buckets/{bucket_name}/namespaces")

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert actual_status == expected_status
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert actual_body["__type"] == expected_error_type
