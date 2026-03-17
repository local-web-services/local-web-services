"""IAM action handler functions."""

from __future__ import annotations

import uuid

from fastapi import Response

from lws.providers.iam._iam_state import _IamState

_ACCOUNT_ID = "000000000000"


def _xml_response(body: str) -> Response:
    """Return an XML response."""
    return Response(content=body, media_type="text/xml")


def _request_id() -> str:
    """Return a random request ID."""
    return str(uuid.uuid4())


async def _handle_create_role(state: _IamState, params: dict[str, str]) -> Response:
    """Handle CreateRole."""
    role_name = params.get("RoleName", "")
    path = params.get("Path", "/")
    assume_role_doc = params.get("AssumeRolePolicyDocument", "{}")
    role_arn = f"arn:aws:iam::{_ACCOUNT_ID}:role{path}{role_name}"
    role = {
        "RoleName": role_name,
        "RoleId": str(uuid.uuid4())[:21].upper(),
        "Arn": role_arn,
        "Path": path,
        "AssumeRolePolicyDocument": assume_role_doc,
        "CreateDate": "2024-01-01T00:00:00Z",
    }
    state.roles[role_name] = role
    state.role_policies.setdefault(role_name, {})
    state.attached_policies.setdefault(role_name, [])

    xml = (
        "<CreateRoleResponse>"
        "<CreateRoleResult>"
        "<Role>"
        f"<RoleName>{role_name}</RoleName>"
        f"<RoleId>{role['RoleId']}</RoleId>"
        f"<Arn>{role_arn}</Arn>"
        f"<Path>{path}</Path>"
        f"<AssumeRolePolicyDocument>{assume_role_doc}</AssumeRolePolicyDocument>"
        "<CreateDate>2024-01-01T00:00:00Z</CreateDate>"
        "</Role>"
        "</CreateRoleResult>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</CreateRoleResponse>"
    )
    return _xml_response(xml)


async def _handle_get_role(state: _IamState, params: dict[str, str]) -> Response:
    """Handle GetRole."""
    role_name = params.get("RoleName", "")
    role = state.roles.get(role_name)
    if role is None:
        xml = (
            "<ErrorResponse>"
            "<Error><Code>NoSuchEntity</Code>"
            f"<Message>The role with name {role_name} cannot be found.</Message>"
            "</Error>"
            f"<RequestId>{_request_id()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=404, media_type="text/xml")

    xml = (
        "<GetRoleResponse>"
        "<GetRoleResult>"
        "<Role>"
        f"<RoleName>{role['RoleName']}</RoleName>"
        f"<RoleId>{role['RoleId']}</RoleId>"
        f"<Arn>{role['Arn']}</Arn>"
        f"<Path>{role['Path']}</Path>"
        f"<AssumeRolePolicyDocument>{role['AssumeRolePolicyDocument']}</AssumeRolePolicyDocument>"
        "<CreateDate>2024-01-01T00:00:00Z</CreateDate>"
        "</Role>"
        "</GetRoleResult>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</GetRoleResponse>"
    )
    return _xml_response(xml)


async def _handle_delete_role(state: _IamState, params: dict[str, str]) -> Response:
    """Handle DeleteRole."""
    role_name = params.get("RoleName", "")
    state.roles.pop(role_name, None)
    state.role_policies.pop(role_name, None)
    state.attached_policies.pop(role_name, None)
    xml = (
        "<DeleteRoleResponse>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</DeleteRoleResponse>"
    )
    return _xml_response(xml)


async def _handle_put_role_policy(state: _IamState, params: dict[str, str]) -> Response:
    """Handle PutRolePolicy."""
    role_name = params.get("RoleName", "")
    policy_name = params.get("PolicyName", "")
    policy_document = params.get("PolicyDocument", "{}")
    state.role_policies.setdefault(role_name, {})[policy_name] = policy_document
    xml = (
        "<PutRolePolicyResponse>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</PutRolePolicyResponse>"
    )
    return _xml_response(xml)


async def _handle_get_role_policy(state: _IamState, params: dict[str, str]) -> Response:
    """Handle GetRolePolicy."""
    role_name = params.get("RoleName", "")
    policy_name = params.get("PolicyName", "")
    doc = state.role_policies.get(role_name, {}).get(policy_name, "{}")
    xml = (
        "<GetRolePolicyResponse>"
        "<GetRolePolicyResult>"
        f"<RoleName>{role_name}</RoleName>"
        f"<PolicyName>{policy_name}</PolicyName>"
        f"<PolicyDocument>{doc}</PolicyDocument>"
        "</GetRolePolicyResult>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</GetRolePolicyResponse>"
    )
    return _xml_response(xml)


async def _handle_delete_role_policy(state: _IamState, params: dict[str, str]) -> Response:
    """Handle DeleteRolePolicy."""
    role_name = params.get("RoleName", "")
    policy_name = params.get("PolicyName", "")
    state.role_policies.get(role_name, {}).pop(policy_name, None)
    xml = (
        "<DeleteRolePolicyResponse>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</DeleteRolePolicyResponse>"
    )
    return _xml_response(xml)


async def _handle_attach_role_policy(state: _IamState, params: dict[str, str]) -> Response:
    """Handle AttachRolePolicy."""
    role_name = params.get("RoleName", "")
    policy_arn = params.get("PolicyArn", "")
    attached = state.attached_policies.setdefault(role_name, [])
    if policy_arn not in attached:
        attached.append(policy_arn)
    xml = (
        "<AttachRolePolicyResponse>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</AttachRolePolicyResponse>"
    )
    return _xml_response(xml)


async def _handle_detach_role_policy(state: _IamState, params: dict[str, str]) -> Response:
    """Handle DetachRolePolicy."""
    role_name = params.get("RoleName", "")
    policy_arn = params.get("PolicyArn", "")
    attached = state.attached_policies.get(role_name, [])
    if policy_arn in attached:
        attached.remove(policy_arn)
    xml = (
        "<DetachRolePolicyResponse>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</DetachRolePolicyResponse>"
    )
    return _xml_response(xml)


async def _handle_list_role_policies(state: _IamState, params: dict[str, str]) -> Response:
    """Handle ListRolePolicies."""
    role_name = params.get("RoleName", "")
    policies = state.role_policies.get(role_name, {})
    members = "".join(f"<member>{name}</member>" for name in policies)
    xml = (
        "<ListRolePoliciesResponse>"
        "<ListRolePoliciesResult>"
        f"<PolicyNames>{members}</PolicyNames>"
        "<IsTruncated>false</IsTruncated>"
        "</ListRolePoliciesResult>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</ListRolePoliciesResponse>"
    )
    return _xml_response(xml)


async def _handle_list_attached_role_policies(
    state: _IamState, params: dict[str, str]
) -> Response:
    """Handle ListAttachedRolePolicies."""
    role_name = params.get("RoleName", "")
    attached = state.attached_policies.get(role_name, [])
    members = "".join(
        f"<member><PolicyArn>{arn}</PolicyArn>"
        f"<PolicyName>{arn.rsplit('/', 1)[-1]}</PolicyName></member>"
        for arn in attached
    )
    xml = (
        "<ListAttachedRolePoliciesResponse>"
        "<ListAttachedRolePoliciesResult>"
        f"<AttachedPolicies>{members}</AttachedPolicies>"
        "<IsTruncated>false</IsTruncated>"
        "</ListAttachedRolePoliciesResult>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</ListAttachedRolePoliciesResponse>"
    )
    return _xml_response(xml)


async def _handle_create_policy(state: _IamState, params: dict[str, str]) -> Response:
    """Handle CreatePolicy."""
    policy_name = params.get("PolicyName", "")
    path = params.get("Path", "/")
    policy_arn = f"arn:aws:iam::{_ACCOUNT_ID}:policy{path}{policy_name}"
    policy = {
        "PolicyName": policy_name,
        "PolicyId": str(uuid.uuid4())[:21].upper(),
        "Arn": policy_arn,
        "Path": path,
        "DefaultVersionId": "v1",
        "AttachmentCount": 0,
        "CreateDate": "2024-01-01T00:00:00Z",
    }
    state.policies[policy_arn] = policy
    xml = (
        "<CreatePolicyResponse>"
        "<CreatePolicyResult>"
        "<Policy>"
        f"<PolicyName>{policy_name}</PolicyName>"
        f"<PolicyId>{policy['PolicyId']}</PolicyId>"
        f"<Arn>{policy_arn}</Arn>"
        f"<Path>{path}</Path>"
        "<DefaultVersionId>v1</DefaultVersionId>"
        "<AttachmentCount>0</AttachmentCount>"
        "<CreateDate>2024-01-01T00:00:00Z</CreateDate>"
        "</Policy>"
        "</CreatePolicyResult>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</CreatePolicyResponse>"
    )
    return _xml_response(xml)


async def _handle_get_policy(state: _IamState, params: dict[str, str]) -> Response:
    """Handle GetPolicy."""
    policy_arn = params.get("PolicyArn", "")
    policy = state.policies.get(policy_arn)
    if policy is None:
        xml = (
            "<ErrorResponse>"
            "<Error><Code>NoSuchEntity</Code>"
            f"<Message>Policy {policy_arn} not found.</Message>"
            "</Error>"
            f"<RequestId>{_request_id()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=404, media_type="text/xml")
    xml = (
        "<GetPolicyResponse>"
        "<GetPolicyResult>"
        "<Policy>"
        f"<PolicyName>{policy['PolicyName']}</PolicyName>"
        f"<PolicyId>{policy['PolicyId']}</PolicyId>"
        f"<Arn>{policy['Arn']}</Arn>"
        f"<Path>{policy['Path']}</Path>"
        f"<DefaultVersionId>{policy['DefaultVersionId']}</DefaultVersionId>"
        "<CreateDate>2024-01-01T00:00:00Z</CreateDate>"
        "</Policy>"
        "</GetPolicyResult>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</GetPolicyResponse>"
    )
    return _xml_response(xml)


async def _handle_delete_policy(state: _IamState, params: dict[str, str]) -> Response:
    """Handle DeletePolicy."""
    policy_arn = params.get("PolicyArn", "")
    state.policies.pop(policy_arn, None)
    xml = (
        "<DeletePolicyResponse>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</DeletePolicyResponse>"
    )
    return _xml_response(xml)


async def _handle_create_instance_profile(state: _IamState, params: dict[str, str]) -> Response:
    """Handle CreateInstanceProfile."""
    name = params.get("InstanceProfileName", "")
    path = params.get("Path", "/")
    profile_arn = f"arn:aws:iam::{_ACCOUNT_ID}:instance-profile{path}{name}"
    profile = {
        "InstanceProfileName": name,
        "InstanceProfileId": str(uuid.uuid4())[:21].upper(),
        "Arn": profile_arn,
        "Path": path,
        "Roles": [],
        "CreateDate": "2024-01-01T00:00:00Z",
    }
    state.instance_profiles[name] = profile
    xml = (
        "<CreateInstanceProfileResponse>"
        "<CreateInstanceProfileResult>"
        "<InstanceProfile>"
        f"<InstanceProfileName>{name}</InstanceProfileName>"
        f"<InstanceProfileId>{profile['InstanceProfileId']}</InstanceProfileId>"
        f"<Arn>{profile_arn}</Arn>"
        f"<Path>{path}</Path>"
        "<Roles/>"
        "<CreateDate>2024-01-01T00:00:00Z</CreateDate>"
        "</InstanceProfile>"
        "</CreateInstanceProfileResult>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</CreateInstanceProfileResponse>"
    )
    return _xml_response(xml)


async def _handle_get_instance_profile(state: _IamState, params: dict[str, str]) -> Response:
    """Handle GetInstanceProfile."""
    name = params.get("InstanceProfileName", "")
    profile = state.instance_profiles.get(name)
    if profile is None:
        xml = (
            "<ErrorResponse>"
            "<Error><Code>NoSuchEntity</Code>"
            f"<Message>Instance profile {name} not found.</Message>"
            "</Error>"
            f"<RequestId>{_request_id()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=404, media_type="text/xml")
    xml = (
        "<GetInstanceProfileResponse>"
        "<GetInstanceProfileResult>"
        "<InstanceProfile>"
        f"<InstanceProfileName>{profile['InstanceProfileName']}</InstanceProfileName>"
        f"<InstanceProfileId>{profile['InstanceProfileId']}</InstanceProfileId>"
        f"<Arn>{profile['Arn']}</Arn>"
        f"<Path>{profile['Path']}</Path>"
        "<Roles/>"
        "<CreateDate>2024-01-01T00:00:00Z</CreateDate>"
        "</InstanceProfile>"
        "</GetInstanceProfileResult>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</GetInstanceProfileResponse>"
    )
    return _xml_response(xml)


async def _handle_delete_instance_profile(state: _IamState, params: dict[str, str]) -> Response:
    """Handle DeleteInstanceProfile."""
    name = params.get("InstanceProfileName", "")
    state.instance_profiles.pop(name, None)
    xml = (
        "<DeleteInstanceProfileResponse>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</DeleteInstanceProfileResponse>"
    )
    return _xml_response(xml)


async def _handle_tag_role(_state: _IamState, _params: dict[str, str]) -> Response:
    """Handle TagRole."""
    xml = (
        "<TagRoleResponse>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</TagRoleResponse>"
    )
    return _xml_response(xml)


async def _handle_untag_role(_state: _IamState, _params: dict[str, str]) -> Response:
    """Handle UntagRole."""
    xml = (
        "<UntagRoleResponse>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</UntagRoleResponse>"
    )
    return _xml_response(xml)


async def _handle_list_roles(state: _IamState, _params: dict[str, str]) -> Response:
    """Handle ListRoles."""
    members = ""
    for role in state.roles.values():
        members += (
            "<member>"
            f"<RoleName>{role['RoleName']}</RoleName>"
            f"<RoleId>{role['RoleId']}</RoleId>"
            f"<Arn>{role['Arn']}</Arn>"
            f"<Path>{role['Path']}</Path>"
            f"<AssumeRolePolicyDocument>{role['AssumeRolePolicyDocument']}"
            "</AssumeRolePolicyDocument>"
            "<CreateDate>2024-01-01T00:00:00Z</CreateDate>"
            "</member>"
        )
    xml = (
        "<ListRolesResponse>"
        "<ListRolesResult>"
        f"<Roles>{members}</Roles>"
        "<IsTruncated>false</IsTruncated>"
        "</ListRolesResult>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</ListRolesResponse>"
    )
    return _xml_response(xml)


async def _handle_list_policies(state: _IamState, _params: dict[str, str]) -> Response:
    """Handle ListPolicies."""
    members = ""
    for policy in state.policies.values():
        members += (
            "<member>"
            f"<PolicyName>{policy['PolicyName']}</PolicyName>"
            f"<PolicyId>{policy['PolicyId']}</PolicyId>"
            f"<Arn>{policy['Arn']}</Arn>"
            f"<Path>{policy['Path']}</Path>"
            f"<DefaultVersionId>{policy['DefaultVersionId']}</DefaultVersionId>"
            f"<AttachmentCount>{policy['AttachmentCount']}</AttachmentCount>"
            "<CreateDate>2024-01-01T00:00:00Z</CreateDate>"
            "</member>"
        )
    xml = (
        "<ListPoliciesResponse>"
        "<ListPoliciesResult>"
        f"<Policies>{members}</Policies>"
        "<IsTruncated>false</IsTruncated>"
        "</ListPoliciesResult>"
        f"<ResponseMetadata><RequestId>{_request_id()}</RequestId></ResponseMetadata>"
        "</ListPoliciesResponse>"
    )
    return _xml_response(xml)


_ACTION_HANDLERS = {
    "CreateRole": _handle_create_role,
    "GetRole": _handle_get_role,
    "DeleteRole": _handle_delete_role,
    "PutRolePolicy": _handle_put_role_policy,
    "GetRolePolicy": _handle_get_role_policy,
    "DeleteRolePolicy": _handle_delete_role_policy,
    "AttachRolePolicy": _handle_attach_role_policy,
    "DetachRolePolicy": _handle_detach_role_policy,
    "ListRolePolicies": _handle_list_role_policies,
    "ListAttachedRolePolicies": _handle_list_attached_role_policies,
    "CreatePolicy": _handle_create_policy,
    "GetPolicy": _handle_get_policy,
    "DeletePolicy": _handle_delete_policy,
    "CreateInstanceProfile": _handle_create_instance_profile,
    "GetInstanceProfile": _handle_get_instance_profile,
    "DeleteInstanceProfile": _handle_delete_instance_profile,
    "TagRole": _handle_tag_role,
    "UntagRole": _handle_untag_role,
    "ListRoles": _handle_list_roles,
    "ListPolicies": _handle_list_policies,
}
