"""Tests for Glacier upload multipart part."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_glacier_app()
    return TestClient(app)


class TestUploadMultipartPart:
    def test_upload_part_returns_204(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 204
        vault_name = "part-vault"
        client.put(f"/-/vaults/{vault_name}")
        init_resp = client.post(
            f"/-/vaults/{vault_name}/multipart-uploads",
            headers={"x-amz-part-size": "1048576"},
        )
        upload_id = init_resp.headers["x-amz-multipart-upload-id"]

        # Act
        response = client.put(
            f"/-/vaults/{vault_name}/multipart-uploads/{upload_id}",
            content=b"part-data",
            headers={"Content-Range": "bytes 0-8/*"},
        )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"

    def test_upload_part_not_found_upload(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 404
        vault_name = "notfound-part-vault"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.put(
            f"/-/vaults/{vault_name}/multipart-uploads/nonexistent-upload-id",
            content=b"data",
            headers={"Content-Range": "bytes 0-3/*"},
        )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
