"""Tests for Glacier InitiateMultipartUpload route."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_glacier_app()
    return TestClient(app)


class TestInitiateMultipartUpload:
    def test_initiate_multipart_upload_returns_201(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 201
        vault_name = "multipart-vault"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.post(
            f"/-/vaults/{vault_name}/multipart-uploads",
            headers={"x-amz-part-size": "1048576"},
        )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"

    def test_initiate_multipart_upload_returns_upload_id_header(self, client: TestClient) -> None:
        # Arrange
        vault_name = "header-multipart-vault"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.post(
            f"/-/vaults/{vault_name}/multipart-uploads",
            headers={"x-amz-part-size": "1048576"},
        )

        # Assert
        actual_upload_id = response.headers.get("x-amz-multipart-upload-id")
        assert actual_upload_id is not None, "Expected upload ID header to be set but was None"
        assert (
            len(actual_upload_id) > 0
        ), f"Expected non-empty upload ID but got {actual_upload_id!r}"

    def test_initiate_multipart_upload_rejected_when_upload_already_in_progress(
        self, client: TestClient
    ) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_type = "InvalidParameterValueException"
        vault_name = "duplicate-upload-vault"
        client.put(f"/-/vaults/{vault_name}")
        client.post(
            f"/-/vaults/{vault_name}/multipart-uploads",
            headers={"x-amz-part-size": "1048576"},
        )

        # Act
        response = client.post(
            f"/-/vaults/{vault_name}/multipart-uploads",
            headers={"x-amz-part-size": "1048576"},
        )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = response.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    def test_initiate_multipart_upload_vault_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 404
        expected_error_type = "ResourceNotFoundException"

        # Act
        response = client.post(
            "/-/vaults/nonexistent/multipart-uploads",
            headers={"x-amz-part-size": "1048576"},
        )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = response.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
