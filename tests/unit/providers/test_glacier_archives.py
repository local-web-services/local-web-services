"""Tests for Glacier archive routes (upload and delete)."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture()
def client() -> TestClient:
    app = create_glacier_app()
    return TestClient(app)


class TestUploadArchive:
    def test_upload_archive_returns_201(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 201
        vault_name = "upload-vault"
        archive_body = b"archive-content"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.post(
            f"/-/vaults/{vault_name}/archives",
            content=archive_body,
        )

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code

    def test_upload_archive_returns_archive_id_header(self, client: TestClient) -> None:
        # Arrange
        vault_name = "header-vault"
        archive_body = b"some-data"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.post(
            f"/-/vaults/{vault_name}/archives",
            content=archive_body,
        )

        # Assert
        actual_archive_id = response.headers.get("x-amz-archive-id")
        assert actual_archive_id is not None
        assert len(actual_archive_id) > 0

    def test_upload_archive_returns_sha256_header(self, client: TestClient) -> None:
        # Arrange
        vault_name = "sha-vault"
        archive_body = b"hash-me"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.post(
            f"/-/vaults/{vault_name}/archives",
            content=archive_body,
        )

        # Assert
        actual_hash = response.headers.get("x-amz-sha256-tree-hash")
        assert actual_hash is not None
        assert len(actual_hash) > 0

    def test_upload_archive_vault_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 404
        expected_error_type = "ResourceNotFoundException"

        # Act
        response = client.post(
            "/-/vaults/nonexistent-vault/archives",
            content=b"data",
        )

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type


class TestDeleteArchive:
    def test_delete_archive_returns_204(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 204
        vault_name = "del-archive-vault"
        client.put(f"/-/vaults/{vault_name}")
        upload_response = client.post(
            f"/-/vaults/{vault_name}/archives",
            content=b"to-be-deleted",
        )
        archive_id = upload_response.headers["x-amz-archive-id"]

        # Act
        response = client.delete(f"/-/vaults/{vault_name}/archives/{archive_id}")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code

    def test_delete_archive_vault_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 404
        expected_error_type = "ResourceNotFoundException"

        # Act
        response = client.delete("/-/vaults/nonexistent/archives/fake-id")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type

    def test_delete_archive_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 404
        expected_error_type = "ResourceNotFoundException"
        vault_name = "archive-missing-vault"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.delete(f"/-/vaults/{vault_name}/archives/nonexistent-id")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
