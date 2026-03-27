"""Tests for Glacier complete multipart upload."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_glacier_app()
    return TestClient(app)


class TestCompleteMultipartUpload:
    def test_complete_multipart_upload_returns_201(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 201
        vault_name = "complete-vault"
        client.put(f"/-/vaults/{vault_name}")
        init_resp = client.post(
            f"/-/vaults/{vault_name}/multipart-uploads",
            headers={"x-amz-part-size": "1048576"},
        )
        upload_id = init_resp.headers["x-amz-multipart-upload-id"]
        client.put(
            f"/-/vaults/{vault_name}/multipart-uploads/{upload_id}",
            content=b"hello",
            headers={"Content-Range": "bytes 0-4/*"},
        )

        # Act
        response = client.post(
            f"/-/vaults/{vault_name}/multipart-uploads/{upload_id}",
            headers={
                "x-amz-sha256-tree-hash": "0" * 64,
                "x-amz-archive-size": "5",
            },
        )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"

    def test_complete_multipart_upload_returns_archive_id(self, client: TestClient) -> None:
        # Arrange
        vault_name = "archive-id-vault"
        client.put(f"/-/vaults/{vault_name}")
        init_resp = client.post(
            f"/-/vaults/{vault_name}/multipart-uploads",
            headers={"x-amz-part-size": "1048576"},
        )
        upload_id = init_resp.headers["x-amz-multipart-upload-id"]

        # Act
        response = client.post(
            f"/-/vaults/{vault_name}/multipart-uploads/{upload_id}",
            headers={"x-amz-sha256-tree-hash": "0" * 64, "x-amz-archive-size": "0"},
        )

        # Assert
        actual_archive_id = response.headers.get("x-amz-archive-id")
        assert actual_archive_id is not None, "Expected archive ID header to be set but was None"
        assert (
            len(actual_archive_id) > 0
        ), f"Expected non-empty archive ID but got {actual_archive_id!r}"
