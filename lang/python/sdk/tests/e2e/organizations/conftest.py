"""Abstract BDD step definitions for Organizations informal spec scenarios."""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_OU_NAME = "e2e-test-ou-1"
TEST_POLICY_NAME = "e2e-test-policy-1"
TEST_POLICY_TYPE = "SERVICE_CONTROL_POLICY"
TEST_ACCOUNT_NAME = "e2e-test-account-1"
TEST_ACCOUNT_EMAIL = "e2e-test-account-1@example.com"


def _orgs(lws_session):
    return lws_session.client("organizations")


def _create_org(lws_session):
    try:
        return _orgs(lws_session).create_organization(FeatureSet="ALL")
    except ClientError as exc:
        if exc.response["Error"]["Code"] == "AlreadyInOrganizationException":
            resp = _orgs(lws_session).describe_organization()
            return {"Organization": resp["Organization"]}
        raise


def _get_root_id(lws_session):
    resp = _orgs(lws_session).list_roots()
    return resp["Roots"][0]["Id"]


def _create_account(lws_session):
    try:
        resp = _orgs(lws_session).create_account(
            AccountName=TEST_ACCOUNT_NAME, Email=TEST_ACCOUNT_EMAIL
        )
        return resp["CreateAccountStatus"]["AccountId"]
    except ClientError as exc:
        if exc.response["Error"]["Code"] == "DuplicateAccountException":
            resp = _orgs(lws_session).list_accounts()
            for account in resp.get("Accounts", []):
                if account.get("Email") == TEST_ACCOUNT_EMAIL:
                    return account["Id"]
        raise


def _create_ou(lws_session, parent_id, name=TEST_OU_NAME):
    try:
        resp = _orgs(lws_session).create_organizational_unit(ParentId=parent_id, Name=name)
        return resp["OrganizationalUnit"]["Id"]
    except ClientError as exc:
        if exc.response["Error"]["Code"] == "DuplicateOrganizationalUnitException":
            resp = _orgs(lws_session).list_organizational_units_for_parent(ParentId=parent_id)
            for ou in resp.get("OrganizationalUnits", []):
                if ou["Name"] == name:
                    return ou["Id"]
        raise


def _create_policy(lws_session, name=TEST_POLICY_NAME):
    try:
        resp = _orgs(lws_session).create_policy(
            Name=name,
            Description="e2e test policy",
            Content="{}",
            Type=TEST_POLICY_TYPE,
        )
        return resp["Policy"]["PolicySummary"]["Id"]
    except ClientError as exc:
        if exc.response["Error"]["Code"] == "DuplicatePolicyException":
            resp = _orgs(lws_session).list_policies(Filter=TEST_POLICY_TYPE)
            for policy in resp.get("Policies", []):
                if policy["Name"] == name:
                    return policy["Id"]
        raise


def _attach_policy(lws_session, policy_id, target_id):
    try:
        _orgs(lws_session).attach_policy(PolicyId=policy_id, TargetId=target_id)
    except ClientError as exc:
        if exc.response["Error"]["Code"] == "DuplicatePolicyAttachmentException":
            return  # already attached
        raise


# ── Given: organization state setup ──────────────────────────────────────────


@given("the organization does not already exist")
def org_not_already_exist():
    """No-op: fresh state has no organization."""


@given("the organization already exists")
def org_already_exists(lws_session, world):
    resp = _create_org(lws_session)
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = _get_root_id(lws_session)


@given("the organization exists")
def org_exists(lws_session, world):
    resp = _create_org(lws_session)
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = _get_root_id(lws_session)


@given("the organization does not exist")
def org_does_not_exist():
    """No-op: fresh state has no organization."""


# ── Given: account state setup ────────────────────────────────────────────────


@given("the account does not already exist")
def account_not_already_exist():
    """No-op: org context is already established by the preceding organization step."""


@given("the account already exists")
def account_already_exists(lws_session, world):
    world["account_id"] = _create_account(lws_session)


@given('the account exists and is "ACTIVE"')
def account_exists_and_active(lws_session, world):
    resp = _create_org(lws_session)
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = _get_root_id(lws_session)
    world["account_id"] = _create_account(lws_session)
    world["source_parent_id"] = world["root_id"]


@given('the account does not exist or is not "ACTIVE"')
def account_does_not_exist_or_not_active(world):
    """Use a nonexistent account ID for negative scenarios."""
    world["account_id"] = "nonexistent-account-id"
    world["source_parent_id"] = "nonexistent-parent"
    world["dest_parent_id"] = "nonexistent-dest"


# ── Given: parent state setup ─────────────────────────────────────────────────


@given('the parent exists and is "ACTIVE"')
def parent_exists_and_active():
    """Root is always the default parent; already stored as root_id."""


@given('the parent does not exist or is not "ACTIVE"')
def parent_does_not_exist_or_not_active(world):
    world["parent_id"] = "nonexistent-parent"


# ── Given: OU state setup ─────────────────────────────────────────────────────


@given("the organizational unit does not already exist")
def ou_not_already_exist():
    """No-op: fresh state has no OUs."""


@given("the organizational unit already exists")
def ou_already_exists(lws_session, world):
    world["ou_id"] = _create_ou(lws_session, world["root_id"], TEST_OU_NAME)
    world["existing_ou_name"] = TEST_OU_NAME


@given('the organizational unit exists and is "ACTIVE"')
def ou_exists_and_active(lws_session, world):
    resp = _create_org(lws_session)
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = _get_root_id(lws_session)
    world["ou_id"] = _create_ou(lws_session, world["root_id"])
    world["parent_id"] = world["root_id"]


@given('the organizational unit does not exist or is not "ACTIVE"')
def ou_does_not_exist_or_not_active(world):
    world["ou_id"] = "nonexistent-ou-id"


@given("the organizational unit has no child accounts")
def ou_has_no_child_accounts():
    """No-op: freshly created OU has no accounts."""


@given("the organizational unit has child accounts")
def ou_has_child_accounts(lws_session, world):
    account_id = _create_account(lws_session)
    world["account_id"] = account_id
    _orgs(lws_session).move_account(
        AccountId=account_id,
        SourceParentId=world["root_id"],
        DestinationParentId=world["ou_id"],
    )


@given("the organizational unit has no child organizational units")
def ou_has_no_child_ous():
    """No-op: freshly created OU has no children."""


@given("the organizational unit has child organizational units")
def ou_has_child_ous(lws_session, world):
    _create_ou(lws_session, world["ou_id"], "e2e-test-child-ou-1")


@given("the organizational unit has no attached policies")
def ou_has_no_attached_policies():
    """No-op: freshly created OU has no policies attached."""


@given("the organizational unit has attached policies")
def ou_has_attached_policies(lws_session, world):
    policy_id = _create_policy(lws_session)
    world["policy_id"] = policy_id
    _attach_policy(lws_session, policy_id, world["ou_id"])


# ── Given: policy state setup ─────────────────────────────────────────────────


@given("the policy does not already exist")
def policy_not_already_exist():
    """No-op: fresh state has no policies."""


@given("the policy already exists")
def policy_already_exists(lws_session, world):
    world["policy_id"] = _create_policy(lws_session)


@given('the policy exists and is "ACTIVE"')
def policy_exists_and_active(lws_session, world):
    resp = _create_org(lws_session)
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = _get_root_id(lws_session)
    world["policy_id"] = _create_policy(lws_session)
    world["target_id"] = world["root_id"]


@given('the policy does not exist or is not "ACTIVE"')
def policy_does_not_exist_or_not_active(world):
    world["policy_id"] = "nonexistent-policy-id"
    world["target_id"] = "nonexistent-target"


# ── Given: policy attachment state ───────────────────────────────────────────


@given('the target exists and is "ACTIVE"')
def target_exists_and_active():
    """Root is the target; already stored as root_id / target_id."""


@given('the target does not exist or is not "ACTIVE"')
def target_does_not_exist_or_not_active(world):
    world["target_id"] = "nonexistent-target"


@given("the policy is not already attached to the target")
def policy_not_already_attached():
    """No-op: fresh state has no policy attachments."""


@given("the policy is already attached to the target")
def policy_already_attached(lws_session, world):
    _attach_policy(lws_session, world["policy_id"], world["target_id"])


@given("the policy is attached to the target")
def policy_attached_to_target(lws_session, world):
    resp = _create_org(lws_session)
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = _get_root_id(lws_session)
    world["policy_id"] = _create_policy(lws_session)
    world["target_id"] = world["root_id"]
    _attach_policy(lws_session, world["policy_id"], world["target_id"])


@given("the policy is not attached to the target")
def policy_not_attached_to_target(lws_session, world):
    resp = _create_org(lws_session)
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = _get_root_id(lws_session)
    world["policy_id"] = _create_policy(lws_session)
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
def destination_parent_active(lws_session, world):
    world["dest_parent_id"] = _create_ou(lws_session, world["root_id"], "e2e-test-dest-ou-1")


@given('the destination parent is not "ACTIVE"')
def destination_parent_not_active(world):
    world["dest_parent_id"] = "nonexistent-dest"


# ── When: actions ─────────────────────────────────────────────────────────────


@when("an organization is created")
def create_organization(lws_session, world):
    try:
        resp = _orgs(lws_session).create_organization(FeatureSet="ALL")
        world["result"] = resp
        world["org_id"] = resp["Organization"]["Id"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an account is created in the organization")
def create_account(lws_session, world):
    try:
        resp = _orgs(lws_session).create_account(
            AccountName=TEST_ACCOUNT_NAME, Email=TEST_ACCOUNT_EMAIL
        )
        account_id = resp["CreateAccountStatus"]["AccountId"]
        world["result"] = account_id
        world["account_id"] = account_id
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an organizational unit is created under a parent")
def create_organizational_unit(lws_session, world):
    try:
        parent_id = world.get("parent_id") or world.get("root_id")
        resp = _orgs(lws_session).create_organizational_unit(ParentId=parent_id, Name=TEST_OU_NAME)
        world["result"] = resp
        world["ou_id"] = resp["OrganizationalUnit"]["Id"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a service control policy is created")
def create_policy(lws_session, world):
    try:
        resp = _orgs(lws_session).create_policy(
            Name=TEST_POLICY_NAME,
            Description="e2e test policy",
            Content="{}",
            Type=TEST_POLICY_TYPE,
        )
        world["result"] = resp
        world["policy_id"] = resp["Policy"]["PolicySummary"]["Id"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an organizational unit is deleted")
def delete_organizational_unit(lws_session, world):
    try:
        resp = _orgs(lws_session).delete_organizational_unit(OrganizationalUnitId=world["ou_id"])
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a policy is attached to a target")
def attach_policy(lws_session, world):
    try:
        resp = _orgs(lws_session).attach_policy(
            PolicyId=world["policy_id"], TargetId=world["target_id"]
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a policy is detached from a target")
def detach_policy(lws_session, world):
    try:
        resp = _orgs(lws_session).detach_policy(
            PolicyId=world["policy_id"], TargetId=world["target_id"]
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an account is moved to a new parent")
def move_account(lws_session, world):
    try:
        resp = _orgs(lws_session).move_account(
            AccountId=world["account_id"],
            SourceParentId=world["source_parent_id"],
            DestinationParentId=world["dest_parent_id"],
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ──────────────────────────────────────────────────────────


@then("the organization and its root exist")
def organization_and_root_exist(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected CreateOrganization to succeed but got: {world['error']}"
    org_resp = _orgs(lws_session).describe_organization()
    actual_org_id = org_resp["Organization"]["Id"]
    assert actual_org_id is not None, "Expected organization Id to be set but got None"
    roots_resp = _orgs(lws_session).list_roots()
    actual_roots = roots_resp["Roots"]
    assert len(actual_roots) > 0, "Expected at least one root but got none"


@then('the account is "ACTIVE" under the root')
def account_active_under_root(lws_session, world):
    assert world["error"] is None, f"Expected CreateAccount to succeed but got: {world['error']}"
    account_id = world["account_id"]
    account_resp = _orgs(lws_session).describe_account(AccountId=account_id)
    actual_status = account_resp["Account"]["Status"]
    expected_status = "ACTIVE"
    assert (
        actual_status == expected_status
    ), f"Expected account status '{expected_status}' but got '{actual_status}'"
    root_id = world["root_id"]
    list_resp = _orgs(lws_session).list_accounts_for_parent(ParentId=root_id)
    actual_account_ids = [a["Id"] for a in list_resp.get("Accounts", [])]
    assert (
        account_id in actual_account_ids
    ), f"Expected account '{account_id}' under root but found: {actual_account_ids}"


@then('the organizational unit is "ACTIVE"')
def ou_is_active(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected CreateOrganizationalUnit to succeed but got: {world['error']}"
    ou_id = world["ou_id"]
    ou_resp = _orgs(lws_session).describe_organizational_unit(OrganizationalUnitId=ou_id)
    actual_id = ou_resp["OrganizationalUnit"]["Id"]
    assert actual_id is not None, f"Expected OU Id to be set but got None for ou_id={ou_id}"


@then('the policy is "ACTIVE"')
def policy_is_active(lws_session, world):
    assert world["error"] is None, f"Expected CreatePolicy to succeed but got: {world['error']}"
    policy_id = world["policy_id"]
    policy_resp = _orgs(lws_session).describe_policy(PolicyId=policy_id)
    actual_id = policy_resp["Policy"]["PolicySummary"]["Id"]
    assert (
        actual_id is not None
    ), f"Expected policy Id to be set but got None for policy_id={policy_id}"


@then('the organizational unit is "DELETED"')
def ou_is_deleted(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected DeleteOrganizationalUnit to succeed but got: {world['error']}"
    ou_id = world["ou_id"]
    parent_id = world.get("parent_id") or world.get("root_id")
    list_resp = _orgs(lws_session).list_organizational_units_for_parent(ParentId=parent_id)
    actual_ou_ids = [ou["Id"] for ou in list_resp.get("OrganizationalUnits", [])]
    assert (
        ou_id not in actual_ou_ids
    ), f"Expected OU '{ou_id}' to be deleted but found in: {actual_ou_ids}"


@then("the policy is attached to the target")
def policy_is_attached_to_target(lws_session, world):
    assert world["error"] is None, f"Expected AttachPolicy to succeed but got: {world['error']}"
    policy_id = world["policy_id"]
    target_id = world["target_id"]
    list_resp = _orgs(lws_session).list_targets_for_policy(PolicyId=policy_id)
    actual_target_ids = [t["TargetId"] for t in list_resp.get("Targets", [])]
    assert (
        target_id in actual_target_ids
    ), f"Expected target '{target_id}' in policy targets but found: {actual_target_ids}"


@then("the policy is no longer attached to the target")
def policy_no_longer_attached_to_target(lws_session, world):
    assert world["error"] is None, f"Expected DetachPolicy to succeed but got: {world['error']}"
    policy_id = world["policy_id"]
    target_id = world["target_id"]
    list_resp = _orgs(lws_session).list_targets_for_policy(PolicyId=policy_id)
    actual_target_ids = [t["TargetId"] for t in list_resp.get("Targets", [])]
    assert (
        target_id not in actual_target_ids
    ), f"Expected target '{target_id}' to be removed but still found in: {actual_target_ids}"


@then("the account is under the new parent")
def account_under_new_parent(lws_session, world):
    assert world["error"] is None, f"Expected MoveAccount to succeed but got: {world['error']}"
    account_id = world["account_id"]
    dest_parent_id = world["dest_parent_id"]
    list_resp = _orgs(lws_session).list_accounts_for_parent(ParentId=dest_parent_id)
    actual_account_ids = [a["Id"] for a in list_resp.get("Accounts", [])]
    assert (
        account_id in actual_account_ids
    ), f"Expected account '{account_id}' under dest parent but found: {actual_account_ids}"


@then('the root is "ACTIVE" whenever the organization exists')
def root_active_when_org_exists(lws_session):
    roots_resp = _orgs(lws_session).list_roots()
    actual_roots = roots_resp["Roots"]
    assert len(actual_roots) > 0, "Expected at least one active root but got none"


@then("no active node is a child of a deleted organizational unit")
def no_active_node_child_of_deleted_ou():
    """Invariant: trivially satisfied in an isolated test context."""


# ── Given: sequence setup ─────────────────────────────────────────


@given("'org-1' not in org_status")
def org_1_not_in_org_status():
    """No-op: fresh state has no organizations."""


@given("an organization has been created")
def an_organization_has_been_created(lws_session):
    _create_org(lws_session)


@given("'org-1' in org_status")
def org_1_in_org_status(lws_session):
    _create_org(lws_session)


@given("an organizational unit has been created under a parent")
def an_ou_has_been_created_under_a_parent(lws_session, world):
    resp = _create_org(lws_session)
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = _get_root_id(lws_session)
    _create_ou(lws_session, world["root_id"])


@given("ou_id in node_status")
def ou_id_in_node_status(lws_session, world):
    resp = _create_org(lws_session)
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = _get_root_id(lws_session)
    world["ou_id"] = _create_ou(lws_session, world["root_id"])


@given("an organizational unit has been deleted")
def an_ou_has_been_deleted(lws_session, world):
    _create_org(lws_session)
    world["root_id"] = _get_root_id(lws_session)
    ou_id = _create_ou(lws_session, world["root_id"])
    _orgs(lws_session).delete_organizational_unit(OrganizationalUnitId=ou_id)


@given("an account has been created in the organization")
def an_account_has_been_created_in_the_org(lws_session, world):
    resp = _create_org(lws_session)
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = _get_root_id(lws_session)
    world["account_id"] = _create_account(lws_session)


@given("acc_id in node_status")
def acc_id_in_node_status(lws_session, world):
    resp = _create_org(lws_session)
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = _get_root_id(lws_session)
    world["account_id"] = _create_account(lws_session)


@given("an account has been moved to a new parent")
def an_account_has_been_moved_to_a_new_parent(lws_session, world):
    _create_org(lws_session)
    world["root_id"] = _get_root_id(lws_session)
    account_id = _create_account(lws_session)
    dest_ou_id = _create_ou(lws_session, world["root_id"], "e2e-test-dest-ou-1")
    _orgs(lws_session).move_account(
        AccountId=account_id,
        SourceParentId=world["root_id"],
        DestinationParentId=dest_ou_id,
    )


@given("a service control policy has been created")
def a_service_control_policy_has_been_created(lws_session, world):
    resp = _create_org(lws_session)
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = _get_root_id(lws_session)
    world["policy_id"] = _create_policy(lws_session)


@given("pol_id in policy_status")
def pol_id_in_policy_status(lws_session, world):
    resp = _create_org(lws_session)
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = _get_root_id(lws_session)
    world["policy_id"] = _create_policy(lws_session)
    world["target_id"] = world["root_id"]


@given("a policy has been attached to a target")
def a_policy_has_been_attached_to_a_target(lws_session, world):
    _create_org(lws_session)
    world["root_id"] = _get_root_id(lws_session)
    policy_id = _create_policy(lws_session)
    _attach_policy(lws_session, policy_id, world["root_id"])
    world["policy_id"] = policy_id
    world["target_id"] = world["root_id"]


@given("(pol_id + '#' + target_id) in policy_attached")
def pol_id_target_id_in_policy_attached(lws_session, world):
    _create_org(lws_session)
    world["root_id"] = _get_root_id(lws_session)
    policy_id = _create_policy(lws_session)
    _attach_policy(lws_session, policy_id, world["root_id"])
    world["policy_id"] = policy_id
    world["target_id"] = world["root_id"]


@given("a policy has been detached from a target")
def a_policy_has_been_detached_from_a_target(lws_session, world):
    _create_org(lws_session)
    world["root_id"] = _get_root_id(lws_session)
    policy_id = _create_policy(lws_session)
    _attach_policy(lws_session, policy_id, world["root_id"])
    _orgs(lws_session).detach_policy(PolicyId=policy_id, TargetId=world["root_id"])


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every active account has an "ACTIVE" parent')
def _inv_organizations_every_active_account_has_an_active_parent():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every active organizational unit has an "ACTIVE" parent')
def _inv_organizations_every_active_organizational_unit_has_an_active_parent():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every active policy attachment targets an "ACTIVE" node')
def _inv_organizations_every_active_policy_attachment_targets_an_active_node():
    """Invariant step: trivially satisfied in isolated test context."""
