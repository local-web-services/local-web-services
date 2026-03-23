"""Tests for lws.providers.organizations.routes -- CreateOrganization operation."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.organizations.routes import create_organizations_app

_TARGET = "AmazonOrganizationsV20161128"


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_organizations_app()
    return TestClient(app, raise_server_exceptions=False)


def _post(client: TestClient, action: str, body: dict) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"{_TARGET}.{action}",
        },
        content=json.dumps(body),
    )
    return resp.json()


class TestCreateOrganization:
    def test_create_organization_returns_org_with_id(self, client: TestClient) -> None:
        # Arrange
        body = {"FeatureSet": "ALL"}

        # Act
        result = _post(client, "CreateOrganization", body)

        # Assert
        actual_org = result.get("Organization", {})
        actual_id = actual_org.get("Id")
        assert actual_id is not None, f"Expected Organization.Id to be set but got: {actual_id}"

    def test_create_organization_returns_master_account(self, client: TestClient) -> None:
        # Arrange
        body = {"FeatureSet": "ALL"}

        # Act
        result = _post(client, "CreateOrganization", body)

        # Assert
        actual_master_id = result.get("Organization", {}).get("MasterAccountId")
        assert (
            actual_master_id is not None
        ), f"Expected Organization.MasterAccountId to be set but got: {actual_master_id}"

    def test_create_organization_duplicate_returns_error(self, client: TestClient) -> None:
        # Arrange
        _post(client, "CreateOrganization", {"FeatureSet": "ALL"})

        # Act
        result = _post(client, "CreateOrganization", {"FeatureSet": "ALL"})

        # Assert
        actual_error_type = result.get("__type")
        assert (
            actual_error_type is not None
        ), "Expected an error when creating a duplicate organization but got none"

    def test_list_roots_after_create_returns_one_root(self, client: TestClient) -> None:
        # Arrange
        _post(client, "CreateOrganization", {"FeatureSet": "ALL"})

        # Act
        result = _post(client, "ListRoots", {})

        # Assert
        actual_roots = result.get("Roots", [])
        expected_root_count = 1
        actual_root_count = len(actual_roots)
        assert (
            actual_root_count == expected_root_count
        ), f"Expected {expected_root_count} root but got {actual_root_count}"
