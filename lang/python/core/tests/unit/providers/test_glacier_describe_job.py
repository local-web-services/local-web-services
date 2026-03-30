"""Tests for Glacier DescribeJob route."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_glacier_app()
    return TestClient(app)


class TestDescribeJob:
    def test_describe_job_returns_job_details(self, client: TestClient) -> None:
        # Arrange
        vault_name = "describe-job-vault"
        client.put(f"/-/vaults/{vault_name}")
        init_resp = client.post(
            f"/-/vaults/{vault_name}/jobs",
            json={"Type": "inventory-retrieval"},
        )
        expected_job_id = init_resp.headers.get("x-amz-job-id")

        # Act
        response = client.get(f"/-/vaults/{vault_name}/jobs/{expected_job_id}")

        # Assert
        actual_job_id = response.json().get("JobId")
        assert (
            actual_job_id == expected_job_id
        ), f"Expected {expected_job_id!r} but got {actual_job_id!r}"

    def test_describe_job_not_found_returns_404(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 404
        vault_name = "describe-job-notfound-vault"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.get(f"/-/vaults/{vault_name}/jobs/nonexistent-job-id")

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"

    def test_describe_job_vault_not_found_returns_404(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 404

        # Act
        response = client.get("/-/vaults/nonexistent-vault/jobs/some-job-id")

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
