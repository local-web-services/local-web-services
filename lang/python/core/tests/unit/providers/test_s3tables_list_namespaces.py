"""Tests for S3 Tables list namespaces operation."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.s3tables.routes import create_s3tables_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_s3tables_app()
    return TestClient(app)


def _create_table_bucket(client: TestClient, name: str) -> None:
    client.put("/buckets", json={"name": name})


class TestListNamespaces:
    def test_list_namespaces_empty(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "empty-list-ns-bucket"
        _create_table_bucket(client, bucket_name)

        # Act
        response = client.get(f"/namespaces/{bucket_name}")

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_body = response.json()
        assert (
            actual_body["namespaces"] == []
        ), f'Expected {[]!r} but got {actual_body["namespaces"]!r}'

    def test_list_namespaces_returns_created(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "list-ns-bucket"
        namespace_name = "listed-ns"
        _create_table_bucket(client, bucket_name)
        client.put(
            f"/namespaces/{bucket_name}",
            json={"namespace": [namespace_name]},
        )

        # Act
        response = client.get(f"/namespaces/{bucket_name}")

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_body = response.json()
        actual_namespaces = [ns["namespace"] for ns in actual_body["namespaces"]]
        assert [
            namespace_name
        ] in actual_namespaces, f"Expected {[namespace_name]!r} to be in {actual_namespaces!r}"

    def test_list_namespaces_bucket_not_found(self, client: TestClient) -> None:
        # Arrange
        bucket_name = "no-such-ns-bucket"

        # Act
        response = client.get(f"/namespaces/{bucket_name}")

        # Assert
        expected_status = 404
        actual_status = response.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_body = response.json()
        expected_error_type = "NotFoundException"
        assert (
            actual_body["__type"] == expected_error_type
        ), f'Expected {expected_error_type!r} but got {actual_body["__type"]!r}'
