"""Tests for Glacier abort multipart upload."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_glacier_app()
    return TestClient(app)


class TestAbortMultipartUpload:
    def test_abort_multipart_upload_returns_204(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 204
        vault_name = "abort-vault"
        client.put(f"/-/vaults/{vault_name}")
        init_resp = client.post(
            f"/-/vaults/{vault_name}/multipart-uploads",
            headers={"x-amz-part-size": "1048576"},
        )
        upload_id = init_resp.headers["x-amz-multipart-upload-id"]

        # Act
        response = client.delete(
            f"/-/vaults/{vault_name}/multipart-uploads/{upload_id}",
        )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"

    def test_abort_multipart_upload_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 404
        vault_name = "abort-notfound-vault"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.delete(
            f"/-/vaults/{vault_name}/multipart-uploads/nonexistent-id",
        )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
