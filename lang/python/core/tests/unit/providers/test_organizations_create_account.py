"""Tests for lws.providers.organizations.routes -- CreateAccount operation."""

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


def _create_org(client: TestClient) -> str:
    _post(client, "CreateOrganization", {"FeatureSet": "ALL"})
    root_result = _post(client, "ListRoots", {})
    return root_result["Roots"][0]["Id"]


class TestCreateAccount:
    def test_create_account_returns_account_id(self, client: TestClient) -> None:
        # Arrange
        _create_org(client)

        # Act
        result = _post(
            client,
            "CreateAccount",
            {"AccountName": "test-account-1", "Email": "test-account-1@example.com"},
        )

        # Assert
        actual_account_id = result.get("CreateAccountStatus", {}).get("AccountId")
        assert (
            actual_account_id is not None
        ), f"Expected CreateAccountStatus.AccountId to be set but got: {actual_account_id}"

    def test_create_account_status_is_active(self, client: TestClient) -> None:
        # Arrange
        _create_org(client)

        # Act
        result = _post(
            client,
            "CreateAccount",
            {"AccountName": "test-account-2", "Email": "test-account-2@example.com"},
        )

        # Assert
        actual_state = result.get("CreateAccountStatus", {}).get("State")
        expected_state = "SUCCEEDED"
        assert (
            actual_state == expected_state
        ), f"Expected CreateAccountStatus.State '{expected_state}' but got '{actual_state}'"

    def test_create_account_duplicate_email_returns_error(self, client: TestClient) -> None:
        # Arrange
        _create_org(client)
        _post(
            client,
            "CreateAccount",
            {"AccountName": "test-account-3", "Email": "dup@example.com"},
        )

        # Act
        result = _post(
            client,
            "CreateAccount",
            {"AccountName": "test-account-3b", "Email": "dup@example.com"},
        )

        # Assert
        actual_error_type = result.get("__type")
        assert actual_error_type is not None, "Expected an error for duplicate email but got none"

    def test_create_account_without_org_returns_error(self, client: TestClient) -> None:
        # Arrange — no org created

        # Act
        result = _post(
            client,
            "CreateAccount",
            {"AccountName": "test-account-4", "Email": "no-org@example.com"},
        )

        # Assert
        actual_error_type = result.get("__type")
        assert (
            actual_error_type is not None
        ), "Expected an error when creating account without org but got none"
