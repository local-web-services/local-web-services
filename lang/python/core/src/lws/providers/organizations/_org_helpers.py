"""AWS Organizations shared helpers: response builders, ARN builders, state predicates."""

from __future__ import annotations

import json

from fastapi import Response

from lws.providers.organizations._org_state import _ACCOUNT_ID, _OrganizationsState


def _json_response(data: dict, status_code: int = 200) -> Response:
    """Return a JSON response in the AWS Organizations wire format."""
    return Response(
        content=json.dumps(data, default=str),
        status_code=status_code,
        media_type="application/x-amz-json-1.1",
    )


def _error_response(code: str, message: str, status_code: int = 400) -> Response:
    """Return an error response in AWS Organizations format."""
    return _json_response({"__type": code, "message": message}, status_code)


def _org_arn(org_id: str) -> str:
    """Build an ARN for an Organization."""
    return f"arn:aws:organizations::{_ACCOUNT_ID}:organization/{org_id}"


def _root_arn(org_id: str, root_id: str) -> str:
    """Build an ARN for a Root node."""
    return f"arn:aws:organizations::{_ACCOUNT_ID}:root/{org_id}/{root_id}"


def _ou_arn(org_id: str, ou_id: str) -> str:
    """Build an ARN for an Organizational Unit."""
    return f"arn:aws:organizations::{_ACCOUNT_ID}:ou/{org_id}/{ou_id}"


def _account_arn(account_id: str) -> str:
    """Build an ARN for an Account."""
    return f"arn:aws:organizations::{_ACCOUNT_ID}:account/{account_id}"


def _policy_arn(org_id: str, policy_id: str) -> str:
    """Build an ARN for a Policy."""
    return (
        f"arn:aws:organizations::{_ACCOUNT_ID}:policy"
        f"/{org_id}/service_control_policy/{policy_id}"
    )


def _target_type(target_id: str, state: _OrganizationsState) -> str | None:
    """Determine the type of a target ID: ROOT, ORGANIZATIONAL_UNIT, or ACCOUNT."""
    if state.root is not None and target_id == state.root["Id"]:
        return "ROOT"
    if target_id in state.ous:
        return "ORGANIZATIONAL_UNIT"
    if target_id in state.accounts:
        return "ACCOUNT"
    return None


def _parent_exists(parent_id: str, state: _OrganizationsState) -> bool:
    """Return True if the parent ID refers to an existing root or active OU."""
    if state.root is not None and parent_id == state.root["Id"]:
        return True
    return parent_id in state.ous


def _ou_has_children(ou_id: str, state: _OrganizationsState) -> bool:
    """Return True if the OU has any child accounts or child OUs."""
    for acct_parent in state.account_parents.values():
        if acct_parent == ou_id:
            return True
    for ou in state.ous.values():
        if ou.get("ParentId") == ou_id:
            return True
    return False


def _ou_has_attached_policies(ou_id: str, state: _OrganizationsState) -> bool:
    """Return True if any policies are attached to the OU."""
    for targets in state.policy_attachments.values():
        if ou_id in targets:
            return True
    return False
