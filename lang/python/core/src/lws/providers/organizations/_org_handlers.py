"""AWS Organizations action handler functions."""

from __future__ import annotations

import time
from typing import Any

from fastapi import Response

from lws.providers.organizations._org_helpers import (
    _account_arn,
    _error_response,
    _json_response,
    _org_arn,
    _ou_arn,
    _ou_has_attached_policies,
    _ou_has_children,
    _parent_exists,
    _policy_arn,
    _root_arn,
    _target_type,
)
from lws.providers.organizations._org_state import (
    _ACCOUNT_ID,
    _next_org_id,
    _next_ou_id,
    _next_policy_id,
    _next_root_id,
    _OrganizationsState,
)


async def _handle_create_organization(state: _OrganizationsState, body: dict) -> Response:
    """Handle CreateOrganization — create a new org and root node."""
    if state.organization is not None:
        return _error_response(
            "AlreadyInOrganizationException",
            "The account is already a member of an organization.",
            status_code=409,
        )

    feature_set = body.get("FeatureSet", "ALL")
    org_id = _next_org_id()
    root_id = _next_root_id()

    org = {
        "Id": org_id,
        "Arn": _org_arn(org_id),
        "FeatureSet": feature_set,
        "MasterAccountId": _ACCOUNT_ID,
        "MasterAccountArn": (
            f"arn:aws:organizations::{_ACCOUNT_ID}:account/{org_id}/{_ACCOUNT_ID}"
        ),
        "MasterAccountEmail": "master@example.com",
        "AvailablePolicyTypes": [{"Type": "SERVICE_CONTROL_POLICY", "Status": "ENABLED"}],
    }
    root = {
        "Id": root_id,
        "Arn": _root_arn(org_id, root_id),
        "Name": "Root",
        "PolicyTypes": [{"Type": "SERVICE_CONTROL_POLICY", "Status": "ENABLED"}],
    }

    state.organization = org
    state.root = root

    return _json_response({"Organization": org})


async def _handle_describe_organization(state: _OrganizationsState, _body: dict) -> Response:
    """Handle DescribeOrganization — return the current org."""
    if state.organization is None:
        return _error_response(
            "AWSOrganizationsNotInUseException",
            "Your account is not a member of an organization.",
        )
    return _json_response({"Organization": state.organization})


async def _handle_list_roots(state: _OrganizationsState, _body: dict) -> Response:
    """Handle ListRoots — return the root node if the org exists."""
    roots = [state.root] if state.root is not None else []
    return _json_response({"Roots": roots})


async def _handle_create_account(state: _OrganizationsState, body: dict) -> Response:
    """Handle CreateAccount — add a new member account under the root."""
    if state.organization is None:
        return _error_response(
            "AWSOrganizationsNotInUseException",
            "Your account is not a member of an organization.",
        )

    account_name = body.get("AccountName", "")
    email = body.get("Email", "")

    for existing in state.accounts.values():
        if existing.get("Email") == email:
            return _error_response(
                "DuplicateAccountException",
                f"An account with email '{email}' already exists.",
                status_code=409,
            )

    account_id = state.next_account_id()
    joined_timestamp = time.time()

    account = {
        "Id": account_id,
        "Arn": _account_arn(account_id),
        "Name": account_name,
        "Email": email,
        "Status": "ACTIVE",
        "JoinedMethod": "CREATED",
        "JoinedTimestamp": joined_timestamp,
    }

    state.accounts[account_id] = account
    state.account_parents[account_id] = state.root["Id"]  # type: ignore[index]

    return _json_response(
        {
            "CreateAccountStatus": {
                "State": "SUCCEEDED",
                "AccountId": account_id,
                "AccountName": account_name,
                "RequestedTimestamp": joined_timestamp,
            }
        }
    )


async def _handle_describe_account(state: _OrganizationsState, body: dict) -> Response:
    """Handle DescribeAccount — return a single account by ID."""
    account_id = body.get("AccountId", "")
    account = state.accounts.get(account_id)
    if account is None:
        return _error_response(
            "AccountNotFoundException",
            f"Account '{account_id}' does not exist.",
        )
    return _json_response({"Account": account})


async def _handle_list_accounts(state: _OrganizationsState, _body: dict) -> Response:
    """Handle ListAccounts — return all accounts in the org."""
    return _json_response({"Accounts": list(state.accounts.values())})


async def _handle_list_accounts_for_parent(state: _OrganizationsState, body: dict) -> Response:
    """Handle ListAccountsForParent — return accounts whose parent matches."""
    parent_id = body.get("ParentId", "")
    accounts = [
        acct
        for acct_id, acct in state.accounts.items()
        if state.account_parents.get(acct_id) == parent_id
    ]
    return _json_response({"Accounts": accounts})


async def _handle_create_organizational_unit(state: _OrganizationsState, body: dict) -> Response:
    """Handle CreateOrganizationalUnit — add a new OU under a parent."""
    if state.organization is None:
        return _error_response(
            "AWSOrganizationsNotInUseException",
            "Your account is not a member of an organization.",
        )

    parent_id = body.get("ParentId", "")
    name = body.get("Name", "")

    if not _parent_exists(parent_id, state):
        return _error_response(
            "ParentNotFoundException",
            f"Parent '{parent_id}' does not exist.",
        )

    for existing_ou in state.ous.values():
        if existing_ou.get("ParentId") == parent_id and existing_ou.get("Name") == name:
            return _error_response(
                "DuplicateOrganizationalUnitException",
                f"An OU named '{name}' already exists under parent '{parent_id}'.",
                status_code=409,
            )

    org_id = state.organization["Id"]
    ou_id = _next_ou_id()
    ou = {
        "Id": ou_id,
        "Arn": _ou_arn(org_id, ou_id),
        "Name": name,
        "ParentId": parent_id,
    }

    state.ous[ou_id] = ou
    return _json_response({"OrganizationalUnit": ou})


async def _handle_describe_organizational_unit(state: _OrganizationsState, body: dict) -> Response:
    """Handle DescribeOrganizationalUnit — return a single OU by ID."""
    ou_id = body.get("OrganizationalUnitId", "")
    ou = state.ous.get(ou_id)
    if ou is None:
        return _error_response(
            "OrganizationalUnitNotFoundException",
            f"Organizational unit '{ou_id}' does not exist.",
        )
    return _json_response({"OrganizationalUnit": ou})


async def _handle_list_organizational_units_for_parent(
    state: _OrganizationsState, body: dict
) -> Response:
    """Handle ListOrganizationalUnitsForParent — return OUs under a parent."""
    parent_id = body.get("ParentId", "")
    ous = [ou for ou in state.ous.values() if ou.get("ParentId") == parent_id]
    return _json_response({"OrganizationalUnits": ous})


async def _handle_delete_organizational_unit(state: _OrganizationsState, body: dict) -> Response:
    """Handle DeleteOrganizationalUnit — remove an OU if it is empty and policy-free."""
    ou_id = body.get("OrganizationalUnitId", "")

    if ou_id not in state.ous:
        return _error_response(
            "OrganizationalUnitNotFoundException",
            f"Organizational unit '{ou_id}' does not exist.",
        )

    if _ou_has_children(ou_id, state):
        return _error_response(
            "OrganizationalUnitNotEmptyException",
            f"Organizational unit '{ou_id}' is not empty.",
        )

    if _ou_has_attached_policies(ou_id, state):
        return _error_response(
            "PolicyChangesInProgressException",
            f"Organizational unit '{ou_id}' has policies attached.",
        )

    del state.ous[ou_id]
    return _json_response({})


async def _handle_move_account(state: _OrganizationsState, body: dict) -> Response:
    """Handle MoveAccount — reparent an account from source to destination."""
    account_id = body.get("AccountId", "")
    source_parent_id = body.get("SourceParentId", "")
    destination_parent_id = body.get("DestinationParentId", "")

    if account_id not in state.accounts:
        return _error_response(
            "AccountNotFoundException",
            f"Account '{account_id}' does not exist.",
        )

    if state.account_parents.get(account_id) != source_parent_id:
        return _error_response(
            "SourceParentNotFoundException",
            f"Account '{account_id}' is not under source parent '{source_parent_id}'.",
        )

    if not _parent_exists(destination_parent_id, state):
        return _error_response(
            "DestinationParentNotFoundException",
            f"Destination parent '{destination_parent_id}' does not exist.",
        )

    state.account_parents[account_id] = destination_parent_id
    return _json_response({})


async def _handle_create_policy(state: _OrganizationsState, body: dict) -> Response:
    """Handle CreatePolicy — add a new policy to the org."""
    if state.organization is None:
        return _error_response(
            "AWSOrganizationsNotInUseException",
            "Your account is not a member of an organization.",
        )

    name = body.get("Name", "")
    description = body.get("Description", "")
    content = body.get("Content", "{}")
    policy_type = body.get("Type", "SERVICE_CONTROL_POLICY")

    for existing in state.policies.values():
        summary = existing["PolicySummary"]
        if summary["Name"] == name and summary["Type"] == policy_type:
            return _error_response(
                "DuplicatePolicyException",
                f"A policy named '{name}' of type '{policy_type}' already exists.",
                status_code=409,
            )

    org_id = state.organization["Id"]
    policy_id = _next_policy_id()
    policy = {
        "PolicySummary": {
            "Id": policy_id,
            "Arn": _policy_arn(org_id, policy_id),
            "Name": name,
            "Description": description,
            "Type": policy_type,
            "AwsManaged": False,
        },
        "Content": content,
    }

    state.policies[policy_id] = policy
    return _json_response({"Policy": policy})


async def _handle_describe_policy(state: _OrganizationsState, body: dict) -> Response:
    """Handle DescribePolicy — return a single policy by ID."""
    policy_id = body.get("PolicyId", "")
    policy = state.policies.get(policy_id)
    if policy is None:
        return _error_response(
            "PolicyNotFoundException",
            f"Policy '{policy_id}' does not exist.",
        )
    return _json_response({"Policy": policy})


async def _handle_list_policies(state: _OrganizationsState, body: dict) -> Response:
    """Handle ListPolicies — return policies filtered by type."""
    policy_filter = body.get("Filter", "")
    policies = [
        p["PolicySummary"]
        for p in state.policies.values()
        if not policy_filter or p["PolicySummary"]["Type"] == policy_filter
    ]
    return _json_response({"Policies": policies})


async def _handle_attach_policy(state: _OrganizationsState, body: dict) -> Response:
    """Handle AttachPolicy — attach a policy to a target."""
    policy_id = body.get("PolicyId", "")
    target_id = body.get("TargetId", "")

    if policy_id not in state.policies:
        return _error_response(
            "PolicyNotFoundException",
            f"Policy '{policy_id}' does not exist.",
        )

    if _target_type(target_id, state) is None:
        return _error_response(
            "TargetNotFoundException",
            f"Target '{target_id}' does not exist.",
        )

    targets = state.policy_attachments.setdefault(policy_id, set())
    if target_id in targets:
        return _error_response(
            "DuplicatePolicyAttachmentException",
            f"Policy '{policy_id}' is already attached to target '{target_id}'.",
            status_code=409,
        )

    targets.add(target_id)
    return _json_response({})


async def _handle_detach_policy(state: _OrganizationsState, body: dict) -> Response:
    """Handle DetachPolicy — remove a policy attachment from a target."""
    policy_id = body.get("PolicyId", "")
    target_id = body.get("TargetId", "")

    targets = state.policy_attachments.get(policy_id, set())
    if target_id not in targets:
        return _error_response(
            "PolicyNotAttachedException",
            f"Policy '{policy_id}' is not attached to target '{target_id}'.",
        )

    targets.discard(target_id)
    return _json_response({})


async def _handle_list_policies_for_target(state: _OrganizationsState, body: dict) -> Response:
    """Handle ListPoliciesForTarget — return policies attached to a target."""
    target_id = body.get("TargetId", "")
    policy_filter = body.get("Filter", "")

    policies = []
    for policy_id, targets in state.policy_attachments.items():
        if target_id not in targets:
            continue
        policy = state.policies.get(policy_id)
        if policy is None:
            continue
        summary = policy["PolicySummary"]
        if policy_filter and summary["Type"] != policy_filter:
            continue
        policies.append(summary)

    return _json_response({"Policies": policies})


async def _handle_list_targets_for_policy(state: _OrganizationsState, body: dict) -> Response:
    """Handle ListTargetsForPolicy — return all targets a policy is attached to."""
    policy_id = body.get("PolicyId", "")

    if policy_id not in state.policies:
        return _error_response(
            "PolicyNotFoundException",
            f"Policy '{policy_id}' does not exist.",
        )

    target_ids = state.policy_attachments.get(policy_id, set())
    targets = []
    for target_id in target_ids:
        ttype = _target_type(target_id, state)
        if ttype is None:
            continue
        targets.append({"TargetId": target_id, "Type": ttype})

    return _json_response({"Targets": targets})


_ACTION_HANDLERS: dict[str, Any] = {
    "CreateOrganization": _handle_create_organization,
    "DescribeOrganization": _handle_describe_organization,
    "ListRoots": _handle_list_roots,
    "CreateAccount": _handle_create_account,
    "DescribeAccount": _handle_describe_account,
    "ListAccounts": _handle_list_accounts,
    "ListAccountsForParent": _handle_list_accounts_for_parent,
    "CreateOrganizationalUnit": _handle_create_organizational_unit,
    "DescribeOrganizationalUnit": _handle_describe_organizational_unit,
    "ListOrganizationalUnitsForParent": _handle_list_organizational_units_for_parent,
    "DeleteOrganizationalUnit": _handle_delete_organizational_unit,
    "MoveAccount": _handle_move_account,
    "CreatePolicy": _handle_create_policy,
    "DescribePolicy": _handle_describe_policy,
    "ListPolicies": _handle_list_policies,
    "AttachPolicy": _handle_attach_policy,
    "DetachPolicy": _handle_detach_policy,
    "ListPoliciesForTarget": _handle_list_policies_for_target,
    "ListTargetsForPolicy": _handle_list_targets_for_policy,
}
