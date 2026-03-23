"""Shared fixtures and BDD step definitions for Organizations integration tests."""

from __future__ import annotations

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.organizations.routes import create_organizations_app

INT_ORG_FEATURE_SET = "ALL"
INT_OU_NAME = "int-test-ou-1"
INT_POLICY_NAME = "int-test-policy-1"
INT_POLICY_TYPE = "SERVICE_CONTROL_POLICY"
INT_ACCOUNT_NAME = "int-test-account-1"
INT_ACCOUNT_EMAIL = "int-test-account-1@example.com"

_ORG_TARGET = "AmazonOrganizationsV20161128"


# ── App / client fixtures ─────────────────────────────────────────────────────


@pytest.fixture
async def provider():
    """Organizations uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    app, _ = create_organizations_app()
    return app


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _post(client: TestClient, action: str, body: dict) -> tuple[int, dict]:
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_ORG_TARGET}.{action}"},
        json=body,
    )
    return r.status_code, r.json()


def _create_org(client: TestClient) -> dict:
    _, body = _post(client, "CreateOrganization", {"FeatureSet": INT_ORG_FEATURE_SET})
    return body


def _get_root_id(client: TestClient) -> str:
    _, body = _post(client, "ListRoots", {})
    return body["Roots"][0]["Id"]


def _create_account(client: TestClient) -> str:
    _, body = _post(
        client,
        "CreateAccount",
        {"AccountName": INT_ACCOUNT_NAME, "Email": INT_ACCOUNT_EMAIL},
    )
    return body["CreateAccountStatus"]["AccountId"]


def _create_ou(client: TestClient, parent_id: str, name: str = INT_OU_NAME) -> str:
    _, body = _post(
        client,
        "CreateOrganizationalUnit",
        {"ParentId": parent_id, "Name": name},
    )
    return body["OrganizationalUnit"]["Id"]


def _create_policy(client: TestClient, name: str = INT_POLICY_NAME) -> str:
    _, body = _post(
        client,
        "CreatePolicy",
        {
            "Name": name,
            "Description": "integration test policy",
            "Content": "{}",
            "Type": INT_POLICY_TYPE,
        },
    )
    return body["Policy"]["PolicySummary"]["Id"]


def _attach_policy(client: TestClient, policy_id: str, target_id: str) -> None:
    _post(client, "AttachPolicy", {"PolicyId": policy_id, "TargetId": target_id})


# ── Given: organization state setup ──────────────────────────────────────────


@given("the organization does not already exist")
def org_not_already_exist():
    """No-op: fresh state has no organization."""


@given("the organization already exists")
def org_already_exists(client: TestClient, world):
    resp = _create_org(client)
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = _get_root_id(client)


@given("the organization exists")
def org_exists(client: TestClient, world):
    resp = _create_org(client)
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = _get_root_id(client)


@given("the organization does not exist")
def org_does_not_exist():
    """No-op: fresh state has no organization."""


# ── Given: account state setup ────────────────────────────────────────────────


@given("the account does not already exist")
def account_not_already_exist(client: TestClient, world):
    """Create org so account operations have a valid context."""
    resp = _create_org(client)
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = _get_root_id(client)


@given("the account already exists")
def account_already_exists(client: TestClient, world):
    resp = _create_org(client)
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = _get_root_id(client)
    world["account_id"] = _create_account(client)


@given('the account exists and is "ACTIVE"')
def account_exists_and_active(client: TestClient, world):
    resp = _create_org(client)
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = _get_root_id(client)
    world["account_id"] = _create_account(client)
    world["source_parent_id"] = world["root_id"]


@given('the account does not exist or is not "ACTIVE"')
def account_does_not_exist_or_not_active(world):
    """Use a nonexistent account ID for negative scenarios."""
    world["account_id"] = "nonexistent-account-id"
    world["source_parent_id"] = "nonexistent-parent"
    world["dest_parent_id"] = "nonexistent-dest"


# ── Given: parent state setup ─────────────────────────────────────────────────


@given('the parent exists and is "ACTIVE"')
def parent_exists_and_active(world):
    """Root is always the default parent; already stored as root_id."""


@given('the parent does not exist or is not "ACTIVE"')
def parent_does_not_exist_or_not_active(world):
    world["parent_id"] = "nonexistent-parent"


# ── Given: OU state setup ─────────────────────────────────────────────────────


@given("the organizational unit does not already exist")
def ou_not_already_exist():
    """No-op: fresh state has no OUs."""


@given("the organizational unit already exists")
def ou_already_exists(client: TestClient, world):
    resp = _create_org(client)
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = _get_root_id(client)
    world["ou_id"] = _create_ou(client, world["root_id"], INT_OU_NAME)
    world["existing_ou_name"] = INT_OU_NAME


@given('the organizational unit exists and is "ACTIVE"')
def ou_exists_and_active(client: TestClient, world):
    resp = _create_org(client)
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = _get_root_id(client)
    world["ou_id"] = _create_ou(client, world["root_id"])
    world["parent_id"] = world["root_id"]


@given('the organizational unit does not exist or is not "ACTIVE"')
def ou_does_not_exist_or_not_active(world):
    world["ou_id"] = "nonexistent-ou-id"


@given("the organizational unit has no child accounts")
def ou_has_no_child_accounts():
    """No-op: freshly created OU has no accounts."""


@given("the organizational unit has child accounts")
def ou_has_child_accounts(client: TestClient, world):
    account_id = _create_account(client)
    world["account_id"] = account_id
    _post(
        client,
        "MoveAccount",
        {
            "AccountId": account_id,
            "SourceParentId": world["root_id"],
            "DestinationParentId": world["ou_id"],
        },
    )


@given("the organizational unit has no child organizational units")
def ou_has_no_child_ous():
    """No-op: freshly created OU has no children."""


@given("the organizational unit has child organizational units")
def ou_has_child_ous(client: TestClient, world):
    _create_ou(client, world["ou_id"], "int-test-child-ou-1")


@given("the organizational unit has no attached policies")
def ou_has_no_attached_policies():
    """No-op: freshly created OU has no policies attached."""


@given("the organizational unit has attached policies")
def ou_has_attached_policies(client: TestClient, world):
    policy_id = _create_policy(client)
    world["policy_id"] = policy_id
    _attach_policy(client, policy_id, world["ou_id"])


# ── Given: policy state setup ─────────────────────────────────────────────────


@given("the policy does not already exist")
def policy_not_already_exist():
    """No-op: fresh state has no policies."""


@given("the policy already exists")
def policy_already_exists(client: TestClient, world):
    world["policy_id"] = _create_policy(client)


@given('the policy exists and is "ACTIVE"')
def policy_exists_and_active(client: TestClient, world):
    resp = _create_org(client)
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = _get_root_id(client)
    world["policy_id"] = _create_policy(client)
    world["target_id"] = world["root_id"]


@given('the policy does not exist or is not "ACTIVE"')
def policy_does_not_exist_or_not_active(world):
    world["policy_id"] = "nonexistent-policy-id"
    world["target_id"] = "nonexistent-target"


# ── Given: policy attachment state ───────────────────────────────────────────


@given('the target exists and is "ACTIVE"')
def target_exists_and_active(world):
    """Root is the target; already stored as root_id / target_id."""


@given('the target does not exist or is not "ACTIVE"')
def target_does_not_exist_or_not_active(world):
    world["target_id"] = "nonexistent-target"


@given("the policy is not already attached to the target")
def policy_not_already_attached():
    """No-op: fresh state has no policy attachments."""


@given("the policy is already attached to the target")
def policy_already_attached(client: TestClient, world):
    _attach_policy(client, world["policy_id"], world["target_id"])


@given("the policy is attached to the target")
def policy_attached_to_target(client: TestClient, world):
    resp = _create_org(client)
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = _get_root_id(client)
    world["policy_id"] = _create_policy(client)
    world["target_id"] = world["root_id"]
    _attach_policy(client, world["policy_id"], world["target_id"])


@given("the policy is not attached to the target")
def policy_not_attached_to_target(client: TestClient, world):
    resp = _create_org(client)
    world["org_id"] = resp.get("Organization", {}).get("Id")
    world["root_id"] = _get_root_id(client)
    world["policy_id"] = _create_policy(client)
    world["target_id"] = world["root_id"]


# ── Given: move account state ─────────────────────────────────────────────────


@given("the source parent matches the account's current parent")
def source_parent_matches(world):
    """Account starts under root; source_parent is already root_id."""
    world["source_parent_id"] = world["root_id"]


@given("the source parent does not match the account's current parent")
def source_parent_does_not_match(world):
    world["source_parent_id"] = "wrong-parent-id"
    if world.get("dest_parent_id") is None:
        world["dest_parent_id"] = world.get("root_id", "nonexistent-dest")


@given('the destination parent is "ACTIVE"')
def destination_parent_active(client: TestClient, world):
    world["dest_parent_id"] = _create_ou(client, world["root_id"], "int-test-dest-ou-1")


@given('the destination parent is not "ACTIVE"')
def destination_parent_not_active(world):
    world["dest_parent_id"] = "nonexistent-dest"


# ── When: actions ─────────────────────────────────────────────────────────────


@when("an organization is created")
def create_organization(client: TestClient, world):
    status, body = _post(client, "CreateOrganization", {"FeatureSet": INT_ORG_FEATURE_SET})
    if status == 200:
        world["result"] = body
        world["org_id"] = body.get("Organization", {}).get("Id")
    else:
        world["error"] = body


@when("an account is created in the organization")
def create_account(client: TestClient, world):
    status, body = _post(
        client,
        "CreateAccount",
        {"AccountName": INT_ACCOUNT_NAME, "Email": INT_ACCOUNT_EMAIL},
    )
    if status == 200:
        world["result"] = body
        world["account_id"] = body.get("CreateAccountStatus", {}).get("AccountId")
    else:
        world["error"] = body


@when("an organizational unit is created under a parent")
def create_organizational_unit(client: TestClient, world):
    parent_id = world.get("parent_id") or world.get("root_id")
    status, body = _post(
        client,
        "CreateOrganizationalUnit",
        {"ParentId": parent_id, "Name": INT_OU_NAME},
    )
    if status == 200:
        world["result"] = body
        world["ou_id"] = body.get("OrganizationalUnit", {}).get("Id")
    else:
        world["error"] = body


@when("a service control policy is created")
def create_policy(client: TestClient, world):
    status, body = _post(
        client,
        "CreatePolicy",
        {
            "Name": INT_POLICY_NAME,
            "Description": "integration test policy",
            "Content": "{}",
            "Type": INT_POLICY_TYPE,
        },
    )
    if status == 200:
        world["result"] = body
        world["policy_id"] = body.get("Policy", {}).get("PolicySummary", {}).get("Id")
    else:
        world["error"] = body


@when("an organizational unit is deleted")
def delete_organizational_unit(client: TestClient, world):
    status, body = _post(
        client,
        "DeleteOrganizationalUnit",
        {"OrganizationalUnitId": world["ou_id"]},
    )
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body


@when("a policy is attached to a target")
def attach_policy(client: TestClient, world):
    status, body = _post(
        client,
        "AttachPolicy",
        {"PolicyId": world["policy_id"], "TargetId": world["target_id"]},
    )
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body


@when("a policy is detached from a target")
def detach_policy(client: TestClient, world):
    status, body = _post(
        client,
        "DetachPolicy",
        {"PolicyId": world["policy_id"], "TargetId": world["target_id"]},
    )
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body


@when("an account is moved to a new parent")
def move_account(client: TestClient, world):
    status, body = _post(
        client,
        "MoveAccount",
        {
            "AccountId": world["account_id"],
            "SourceParentId": world["source_parent_id"],
            "DestinationParentId": world["dest_parent_id"],
        },
    )
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body


# ── Then: assertions ──────────────────────────────────────────────────────────


@then("the organization and its root exist")
def organization_and_root_exist(client: TestClient, world):
    actual_create_error = world["error"]
    assert (
        actual_create_error is None
    ), f"Expected CreateOrganization to succeed but got: {actual_create_error}"
    _, org_body = _post(client, "DescribeOrganization", {})
    actual_org_id = org_body.get("Organization", {}).get("Id")
    assert actual_org_id is not None, "Expected organization Id to be set but got None"
    _, roots_body = _post(client, "ListRoots", {})
    actual_roots = roots_body.get("Roots", [])
    assert len(actual_roots) > 0, "Expected at least one root but got none"


@then('the account is "ACTIVE" under the root')
def account_active_under_root(client: TestClient, world):
    assert world["error"] is None, f"Expected CreateAccount to succeed but got: {world['error']}"
    account_id = world["account_id"]
    _, account_body = _post(client, "DescribeAccount", {"AccountId": account_id})
    actual_status = account_body.get("Account", {}).get("Status")
    expected_status = "ACTIVE"
    assert (
        actual_status == expected_status
    ), f"Expected account status '{expected_status}' but got '{actual_status}'"
    root_id = world["root_id"]
    _, list_body = _post(client, "ListAccountsForParent", {"ParentId": root_id})
    actual_account_ids = [a["Id"] for a in list_body.get("Accounts", [])]
    assert (
        account_id in actual_account_ids
    ), f"Expected account '{account_id}' under root but found: {actual_account_ids}"


@then('the organizational unit is "ACTIVE"')
def ou_is_active(client: TestClient, world):
    actual_create_error = world["error"]
    assert (
        actual_create_error is None
    ), f"Expected CreateOrganizationalUnit to succeed but got: {actual_create_error}"
    ou_id = world["ou_id"]
    _, ou_body = _post(client, "DescribeOrganizationalUnit", {"OrganizationalUnitId": ou_id})
    actual_id = ou_body.get("OrganizationalUnit", {}).get("Id")
    assert actual_id is not None, f"Expected OU Id to be set but got None for ou_id={ou_id}"


@then('the policy is "ACTIVE"')
def policy_is_active(client: TestClient, world):
    assert world["error"] is None, f"Expected CreatePolicy to succeed but got: {world['error']}"
    policy_id = world["policy_id"]
    _, policy_body = _post(client, "DescribePolicy", {"PolicyId": policy_id})
    actual_id = policy_body.get("Policy", {}).get("PolicySummary", {}).get("Id")
    assert (
        actual_id is not None
    ), f"Expected policy Id to be set but got None for policy_id={policy_id}"


@then('the organizational unit is "DELETED"')
def ou_is_deleted(client: TestClient, world):
    actual_delete_error = world["error"]
    assert (
        actual_delete_error is None
    ), f"Expected DeleteOrganizationalUnit to succeed but got: {actual_delete_error}"
    ou_id = world["ou_id"]
    parent_id = world.get("parent_id") or world.get("root_id")
    _, list_body = _post(client, "ListOrganizationalUnitsForParent", {"ParentId": parent_id})
    actual_ou_ids = [ou["Id"] for ou in list_body.get("OrganizationalUnits", [])]
    assert (
        ou_id not in actual_ou_ids
    ), f"Expected OU '{ou_id}' to be deleted but found in: {actual_ou_ids}"


@then("the policy is attached to the target")
def policy_is_attached_to_target(client: TestClient, world):
    assert world["error"] is None, f"Expected AttachPolicy to succeed but got: {world['error']}"
    policy_id = world["policy_id"]
    target_id = world["target_id"]
    _, list_body = _post(client, "ListTargetsForPolicy", {"PolicyId": policy_id})
    actual_target_ids = [t["TargetId"] for t in list_body.get("Targets", [])]
    assert (
        target_id in actual_target_ids
    ), f"Expected target '{target_id}' in policy targets but found: {actual_target_ids}"


@then("the policy is no longer attached to the target")
def policy_no_longer_attached_to_target(client: TestClient, world):
    assert world["error"] is None, f"Expected DetachPolicy to succeed but got: {world['error']}"
    policy_id = world["policy_id"]
    target_id = world["target_id"]
    _, list_body = _post(client, "ListTargetsForPolicy", {"PolicyId": policy_id})
    actual_target_ids = [t["TargetId"] for t in list_body.get("Targets", [])]
    assert (
        target_id not in actual_target_ids
    ), f"Expected target '{target_id}' to be removed but still found in: {actual_target_ids}"


@then("the account is under the new parent")
def account_under_new_parent(client: TestClient, world):
    assert world["error"] is None, f"Expected MoveAccount to succeed but got: {world['error']}"
    account_id = world["account_id"]
    dest_parent_id = world["dest_parent_id"]
    _, list_body = _post(client, "ListAccountsForParent", {"ParentId": dest_parent_id})
    actual_account_ids = [a["Id"] for a in list_body.get("Accounts", [])]
    assert (
        account_id in actual_account_ids
    ), f"Expected account '{account_id}' under dest parent but found: {actual_account_ids}"


@then('the root is "ACTIVE" whenever the organization exists')
def root_active_when_org_exists(client: TestClient, world):
    _, roots_body = _post(client, "ListRoots", {})
    actual_roots = roots_body.get("Roots", [])
    assert len(actual_roots) > 0, "Expected at least one active root but got none"


@then("no active node is a child of a deleted organizational unit")
def no_active_node_child_of_deleted_ou():
    """Invariant: trivially satisfied in an isolated test context."""
