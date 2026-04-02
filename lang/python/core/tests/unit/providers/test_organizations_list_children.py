"""Tests for _handle_list_children in organizations handlers."""

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


def _setup_org(client: TestClient) -> str:
    _post(client, "CreateOrganization", {"FeatureSet": "ALL"})
    root_result = _post(client, "ListRoots", {})
    return root_result["Roots"][0]["Id"]


class TestHandleListChildren:
    def test_list_children_account_type_returns_accounts(self, client: TestClient) -> None:
        # Arrange
        root_id = _setup_org(client)
        ou_result = _post(
            client, "CreateOrganizationalUnit", {"ParentId": root_id, "Name": "prod-ou"}
        )
        ou_id = ou_result["OrganizationalUnit"]["Id"]
        acc_result_1 = _post(
            client,
            "CreateAccount",
            {"AccountName": "account-a", "Email": "account-a@example.com"},
        )
        acc_id_1 = acc_result_1["CreateAccountStatus"]["AccountId"]
        _post(
            client,
            "MoveAccount",
            {"AccountId": acc_id_1, "SourceParentId": root_id, "DestinationParentId": ou_id},
        )
        acc_result_2 = _post(
            client,
            "CreateAccount",
            {"AccountName": "account-b", "Email": "account-b@example.com"},
        )
        acc_id_2 = acc_result_2["CreateAccountStatus"]["AccountId"]
        _post(
            client,
            "MoveAccount",
            {"AccountId": acc_id_2, "SourceParentId": root_id, "DestinationParentId": ou_id},
        )

        # Act
        actual_result = _post(client, "ListChildren", {"ParentId": ou_id, "ChildType": "ACCOUNT"})

        # Assert
        actual_ids = {c["Id"] for c in actual_result.get("Children", [])}
        expected_ids = {acc_id_1, acc_id_2}
        assert actual_ids == expected_ids

    def test_list_children_ou_type_returns_child_ous(self, client: TestClient) -> None:
        # Arrange
        root_id = _setup_org(client)
        ou_result_1 = _post(
            client, "CreateOrganizationalUnit", {"ParentId": root_id, "Name": "ou-alpha"}
        )
        ou_id_1 = ou_result_1["OrganizationalUnit"]["Id"]
        ou_result_2 = _post(
            client, "CreateOrganizationalUnit", {"ParentId": root_id, "Name": "ou-beta"}
        )
        ou_id_2 = ou_result_2["OrganizationalUnit"]["Id"]
        ou_result_3 = _post(
            client, "CreateOrganizationalUnit", {"ParentId": root_id, "Name": "ou-gamma"}
        )
        ou_id_3 = ou_result_3["OrganizationalUnit"]["Id"]

        # Act
        actual_result = _post(
            client, "ListChildren", {"ParentId": root_id, "ChildType": "ORGANIZATIONAL_UNIT"}
        )

        # Assert
        actual_ids = {c["Id"] for c in actual_result.get("Children", [])}
        expected_ids = {ou_id_1, ou_id_2, ou_id_3}
        assert actual_ids == expected_ids

    def test_list_children_invalid_child_type_returns_error(self, client: TestClient) -> None:
        # Arrange
        root_id = _setup_org(client)

        # Act
        actual_result = _post(client, "ListChildren", {"ParentId": root_id, "ChildType": "INVALID"})

        # Assert
        actual_error_type = actual_result.get("__type")
        expected_error_type = "InvalidInputException"
        assert actual_error_type == expected_error_type

    def test_list_children_account_type_child_has_correct_type_field(
        self, client: TestClient
    ) -> None:
        # Arrange
        root_id = _setup_org(client)
        _post(
            client,
            "CreateAccount",
            {"AccountName": "typed-account", "Email": "typed@example.com"},
        )

        # Act
        actual_result = _post(client, "ListChildren", {"ParentId": root_id, "ChildType": "ACCOUNT"})

        # Assert
        actual_children = actual_result.get("Children", [])
        assert len(actual_children) > 0
        actual_type = actual_children[0].get("Type")
        expected_type = "ACCOUNT"
        assert actual_type == expected_type
