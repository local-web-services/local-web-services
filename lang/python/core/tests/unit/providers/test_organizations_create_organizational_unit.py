"""Tests for lws.providers.organizations.routes -- CreateOrganizationalUnit operation."""

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


def _create_org_and_get_root(client: TestClient) -> str:
    _post(client, "CreateOrganization", {"FeatureSet": "ALL"})
    result = _post(client, "ListRoots", {})
    return result["Roots"][0]["Id"]


class TestCreateOrganizationalUnit:
    def test_create_ou_returns_ou_id(self, client: TestClient) -> None:
        # Arrange
        root_id = _create_org_and_get_root(client)

        # Act
        result = _post(
            client,
            "CreateOrganizationalUnit",
            {"ParentId": root_id, "Name": "test-ou-1"},
        )

        # Assert
        actual_ou_id = result.get("OrganizationalUnit", {}).get("Id")
        assert (
            actual_ou_id is not None
        ), f"Expected OrganizationalUnit.Id to be set but got: {actual_ou_id}"

    def test_create_ou_name_matches_input(self, client: TestClient) -> None:
        # Arrange
        root_id = _create_org_and_get_root(client)
        expected_name = "test-ou-named"

        # Act
        result = _post(
            client,
            "CreateOrganizationalUnit",
            {"ParentId": root_id, "Name": expected_name},
        )

        # Assert
        actual_name = result.get("OrganizationalUnit", {}).get("Name")
        assert (
            actual_name == expected_name
        ), f"Expected OU name '{expected_name}' but got '{actual_name}'"

    def test_create_ou_duplicate_name_returns_error(self, client: TestClient) -> None:
        # Arrange
        root_id = _create_org_and_get_root(client)
        _post(client, "CreateOrganizationalUnit", {"ParentId": root_id, "Name": "dup-ou"})

        # Act
        result = _post(
            client,
            "CreateOrganizationalUnit",
            {"ParentId": root_id, "Name": "dup-ou"},
        )

        # Assert
        actual_error_type = result.get("__type")
        assert actual_error_type is not None, "Expected an error for duplicate OU name but got none"

    def test_create_ou_nonexistent_parent_returns_error(self, client: TestClient) -> None:
        # Arrange
        _post(client, "CreateOrganization", {"FeatureSet": "ALL"})

        # Act
        result = _post(
            client,
            "CreateOrganizationalUnit",
            {"ParentId": "nonexistent-parent-id", "Name": "orphan-ou"},
        )

        # Assert
        actual_error_type = result.get("__type")
        assert (
            actual_error_type is not None
        ), "Expected an error for nonexistent parent but got none"

    def test_create_ou_without_org_returns_error(self, client: TestClient) -> None:
        # Arrange — no org created

        # Act
        result = _post(
            client,
            "CreateOrganizationalUnit",
            {"ParentId": "r-0000", "Name": "no-org-ou"},
        )

        # Assert
        actual_error_type = result.get("__type")
        assert (
            actual_error_type is not None
        ), "Expected an error when creating OU without org but got none"
