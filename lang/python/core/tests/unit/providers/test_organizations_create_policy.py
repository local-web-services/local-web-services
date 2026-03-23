"""Tests for lws.providers.organizations.routes -- CreatePolicy operation."""

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


def _create_policy(client: TestClient, name: str = "test-policy-1") -> dict:
    return _post(
        client,
        "CreatePolicy",
        {
            "Name": name,
            "Description": "unit test policy",
            "Content": "{}",
            "Type": "SERVICE_CONTROL_POLICY",
        },
    )


class TestCreatePolicy:
    def test_create_policy_returns_policy_id(self, client: TestClient) -> None:
        # Arrange
        _post(client, "CreateOrganization", {"FeatureSet": "ALL"})

        # Act
        result = _create_policy(client)

        # Assert
        actual_policy_id = result.get("Policy", {}).get("PolicySummary", {}).get("Id")
        assert (
            actual_policy_id is not None
        ), f"Expected Policy.PolicySummary.Id to be set but got: {actual_policy_id}"

    def test_create_policy_name_matches_input(self, client: TestClient) -> None:
        # Arrange
        _post(client, "CreateOrganization", {"FeatureSet": "ALL"})
        expected_name = "named-policy-1"

        # Act
        result = _create_policy(client, name=expected_name)

        # Assert
        actual_name = result.get("Policy", {}).get("PolicySummary", {}).get("Name")
        assert (
            actual_name == expected_name
        ), f"Expected policy name '{expected_name}' but got '{actual_name}'"

    def test_create_policy_duplicate_name_returns_error(self, client: TestClient) -> None:
        # Arrange
        _post(client, "CreateOrganization", {"FeatureSet": "ALL"})
        _create_policy(client, name="dup-policy")

        # Act
        result = _create_policy(client, name="dup-policy")

        # Assert
        actual_error_type = result.get("__type")
        assert (
            actual_error_type is not None
        ), "Expected an error for duplicate policy name but got none"

    def test_create_policy_without_org_returns_error(self, client: TestClient) -> None:
        # Arrange — no org created

        # Act
        result = _create_policy(client, name="no-org-policy")

        # Assert
        actual_error_type = result.get("__type")
        assert (
            actual_error_type is not None
        ), "Expected an error when creating policy without org but got none"
