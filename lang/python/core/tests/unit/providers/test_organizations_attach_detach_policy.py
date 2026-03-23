"""Tests for lws.providers.organizations.routes -- AttachPolicy and DetachPolicy operations."""

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


def _create_policy(client: TestClient, name: str = "attach-test-policy") -> str:
    result = _post(
        client,
        "CreatePolicy",
        {"Name": name, "Description": "", "Content": "{}", "Type": "SERVICE_CONTROL_POLICY"},
    )
    return result["Policy"]["PolicySummary"]["Id"]


class TestAttachDetachPolicy:
    def test_attach_policy_to_root_succeeds(self, client: TestClient) -> None:
        # Arrange
        root_id = _create_org_and_get_root(client)
        policy_id = _create_policy(client)

        # Act
        result = _post(client, "AttachPolicy", {"PolicyId": policy_id, "TargetId": root_id})

        # Assert
        actual_error = result.get("__type")
        assert (
            actual_error is None
        ), f"Expected AttachPolicy to succeed but got error: {actual_error}"

    def test_attach_policy_appears_in_list_targets(self, client: TestClient) -> None:
        # Arrange
        root_id = _create_org_and_get_root(client)
        policy_id = _create_policy(client, name="list-target-policy")
        _post(client, "AttachPolicy", {"PolicyId": policy_id, "TargetId": root_id})

        # Act
        result = _post(client, "ListTargetsForPolicy", {"PolicyId": policy_id})

        # Assert
        actual_target_ids = [t["TargetId"] for t in result.get("Targets", [])]
        assert (
            root_id in actual_target_ids
        ), f"Expected root '{root_id}' in policy targets but found: {actual_target_ids}"

    def test_attach_policy_duplicate_returns_error(self, client: TestClient) -> None:
        # Arrange
        root_id = _create_org_and_get_root(client)
        policy_id = _create_policy(client, name="dup-attach-policy")
        _post(client, "AttachPolicy", {"PolicyId": policy_id, "TargetId": root_id})

        # Act
        result = _post(client, "AttachPolicy", {"PolicyId": policy_id, "TargetId": root_id})

        # Assert
        actual_error_type = result.get("__type")
        assert (
            actual_error_type is not None
        ), "Expected an error for duplicate policy attachment but got none"

    def test_attach_nonexistent_policy_returns_error(self, client: TestClient) -> None:
        # Arrange
        root_id = _create_org_and_get_root(client)

        # Act
        result = _post(
            client,
            "AttachPolicy",
            {"PolicyId": "nonexistent-policy-id", "TargetId": root_id},
        )

        # Assert
        actual_error_type = result.get("__type")
        assert (
            actual_error_type is not None
        ), "Expected an error attaching nonexistent policy but got none"

    def test_detach_policy_removes_it_from_targets(self, client: TestClient) -> None:
        # Arrange
        root_id = _create_org_and_get_root(client)
        policy_id = _create_policy(client, name="detach-policy")
        _post(client, "AttachPolicy", {"PolicyId": policy_id, "TargetId": root_id})

        # Act
        result = _post(client, "DetachPolicy", {"PolicyId": policy_id, "TargetId": root_id})

        # Assert
        actual_error = result.get("__type")
        assert (
            actual_error is None
        ), f"Expected DetachPolicy to succeed but got error: {actual_error}"
        list_result = _post(client, "ListTargetsForPolicy", {"PolicyId": policy_id})
        actual_target_ids = [t["TargetId"] for t in list_result.get("Targets", [])]
        assert (
            root_id not in actual_target_ids
        ), f"Expected root '{root_id}' absent after detach but found in: {actual_target_ids}"

    def test_detach_policy_not_attached_returns_error(self, client: TestClient) -> None:
        # Arrange
        root_id = _create_org_and_get_root(client)
        policy_id = _create_policy(client, name="never-attached-policy")

        # Act
        result = _post(client, "DetachPolicy", {"PolicyId": policy_id, "TargetId": root_id})

        # Assert
        actual_error_type = result.get("__type")
        assert (
            actual_error_type is not None
        ), "Expected an error detaching a policy not attached to the target but got none"
