"""Tests for _handle_list_tags_for_resource in organizations handlers."""

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


def _setup_org_with_account(client: TestClient) -> str:
    _post(client, "CreateOrganization", {"FeatureSet": "ALL"})
    result = _post(
        client,
        "CreateAccount",
        {"AccountName": "tag-test-account", "Email": "tag-test@example.com"},
    )
    return result["CreateAccountStatus"]["AccountId"]


class TestHandleListTagsForResource:
    def test_list_tags_for_tagged_account_returns_tags(self, client: TestClient) -> None:
        # Arrange
        _setup_org_with_account(client)
        app, state = create_organizations_app()
        tagged_client = TestClient(app, raise_server_exceptions=False)
        _post(tagged_client, "CreateOrganization", {"FeatureSet": "ALL"})
        _post(
            tagged_client,
            "CreateAccount",
            {"AccountName": "tagged-account", "Email": "tagged@example.com"},
        )
        result = _post(tagged_client, "ListAccounts", {})
        acct_id = result["Accounts"][0]["Id"]
        state.resource_tags[acct_id] = {"env": "prod", "team": "payments"}

        # Act
        actual_result = _post(tagged_client, "ListTagsForResource", {"ResourceId": acct_id})

        # Assert
        actual_tags = {t["Key"]: t["Value"] for t in actual_result.get("Tags", [])}
        expected_tags = {"env": "prod", "team": "payments"}
        assert actual_tags == expected_tags

    def test_list_tags_for_untagged_ou_returns_empty_list(self, client: TestClient) -> None:
        # Arrange
        _post(client, "CreateOrganization", {"FeatureSet": "ALL"})
        root_result = _post(client, "ListRoots", {})
        root_id = root_result["Roots"][0]["Id"]
        ou_result = _post(
            client,
            "CreateOrganizationalUnit",
            {"ParentId": root_id, "Name": "test-ou"},
        )
        ou_id = ou_result["OrganizationalUnit"]["Id"]

        # Act
        actual_result = _post(client, "ListTagsForResource", {"ResourceId": ou_id})

        # Assert
        actual_tags = actual_result.get("Tags", None)
        expected_tags: list = []
        assert actual_tags == expected_tags

    def test_list_tags_for_unknown_resource_returns_empty_list(self, client: TestClient) -> None:
        # Arrange
        resource_id = "unknown-resource-id"

        # Act
        actual_result = _post(client, "ListTagsForResource", {"ResourceId": resource_id})

        # Assert
        actual_tags = actual_result.get("Tags", None)
        expected_tags: list = []
        assert actual_tags == expected_tags
