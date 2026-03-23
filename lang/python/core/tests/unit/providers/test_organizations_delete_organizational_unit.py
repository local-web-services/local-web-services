"""Tests for lws.providers.organizations.routes -- DeleteOrganizationalUnit operation."""

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


def _create_ou(client: TestClient, parent_id: str, name: str = "test-ou-del") -> str:
    result = _post(client, "CreateOrganizationalUnit", {"ParentId": parent_id, "Name": name})
    return result["OrganizationalUnit"]["Id"]


def _create_account(client: TestClient) -> str:
    result = _post(
        client,
        "CreateAccount",
        {"AccountName": "del-test-acct", "Email": "del-test-acct@example.com"},
    )
    return result["CreateAccountStatus"]["AccountId"]


def _create_policy(client: TestClient) -> str:
    result = _post(
        client,
        "CreatePolicy",
        {
            "Name": "del-test-policy",
            "Description": "",
            "Content": "{}",
            "Type": "SERVICE_CONTROL_POLICY",
        },
    )
    return result["Policy"]["PolicySummary"]["Id"]


class TestDeleteOrganizationalUnit:
    def test_delete_ou_removes_it_from_parent(self, client: TestClient) -> None:
        # Arrange
        root_id = _create_org_and_get_root(client)
        ou_id = _create_ou(client, root_id)

        # Act
        result = _post(client, "DeleteOrganizationalUnit", {"OrganizationalUnitId": ou_id})

        # Assert
        actual_error = result.get("__type")
        assert (
            actual_error is None
        ), f"Expected DeleteOrganizationalUnit to succeed but got error: {actual_error}"
        list_result = _post(client, "ListOrganizationalUnitsForParent", {"ParentId": root_id})
        actual_ou_ids = [ou["Id"] for ou in list_result.get("OrganizationalUnits", [])]
        assert (
            ou_id not in actual_ou_ids
        ), f"Expected OU '{ou_id}' to be absent after delete but found in: {actual_ou_ids}"

    def test_delete_nonexistent_ou_returns_error(self, client: TestClient) -> None:
        # Arrange
        _create_org_and_get_root(client)

        # Act
        result = _post(
            client,
            "DeleteOrganizationalUnit",
            {"OrganizationalUnitId": "ou-nonexistent"},
        )

        # Assert
        actual_error_type = result.get("__type")
        assert (
            actual_error_type is not None
        ), "Expected an error deleting nonexistent OU but got none"

    def test_delete_ou_with_child_account_returns_error(self, client: TestClient) -> None:
        # Arrange
        root_id = _create_org_and_get_root(client)
        ou_id = _create_ou(client, root_id, "ou-with-acct")
        account_id = _create_account(client)
        _post(
            client,
            "MoveAccount",
            {"AccountId": account_id, "SourceParentId": root_id, "DestinationParentId": ou_id},
        )

        # Act
        result = _post(client, "DeleteOrganizationalUnit", {"OrganizationalUnitId": ou_id})

        # Assert
        actual_error_type = result.get("__type")
        assert (
            actual_error_type is not None
        ), "Expected an error deleting OU with child accounts but got none"

    def test_delete_ou_with_child_ou_returns_error(self, client: TestClient) -> None:
        # Arrange
        root_id = _create_org_and_get_root(client)
        parent_ou_id = _create_ou(client, root_id, "parent-ou")
        _create_ou(client, parent_ou_id, "child-ou")

        # Act
        result = _post(client, "DeleteOrganizationalUnit", {"OrganizationalUnitId": parent_ou_id})

        # Assert
        actual_error_type = result.get("__type")
        assert (
            actual_error_type is not None
        ), "Expected an error deleting OU with child OUs but got none"

    def test_delete_ou_with_attached_policy_returns_error(self, client: TestClient) -> None:
        # Arrange
        root_id = _create_org_and_get_root(client)
        ou_id = _create_ou(client, root_id, "ou-with-policy")
        policy_id = _create_policy(client)
        _post(client, "AttachPolicy", {"PolicyId": policy_id, "TargetId": ou_id})

        # Act
        result = _post(client, "DeleteOrganizationalUnit", {"OrganizationalUnitId": ou_id})

        # Assert
        actual_error_type = result.get("__type")
        assert (
            actual_error_type is not None
        ), "Expected an error deleting OU with attached policy but got none"
