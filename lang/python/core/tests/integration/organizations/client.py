"""Test client for organizations tests."""

from __future__ import annotations

from .constants import (
    _ORG_TARGET,
    INT_ACCOUNT_EMAIL,
    INT_ACCOUNT_NAME,
    INT_ORG_FEATURE_SET,
    INT_OU_NAME,
    INT_POLICY_NAME,
    INT_POLICY_TYPE,
)


class OrganizationsTestClient:
    def __init__(self, client):
        self._client = client

    def post(self, action: str, body: dict) -> tuple[int, dict]:
        r = self._client.post("/", headers={"X-Amz-Target": f"{_ORG_TARGET}.{action}"}, json=body)
        return (r.status_code, r.json())

    def create_org(self) -> dict:
        _, body = self.post("CreateOrganization", {"FeatureSet": INT_ORG_FEATURE_SET})
        return body

    def get_root_id(self) -> str:
        _, body = self.post("ListRoots", {})
        return body["Roots"][0]["Id"]

    def create_account(self) -> str:
        _, body = self.post(
            "CreateAccount", {"AccountName": INT_ACCOUNT_NAME, "Email": INT_ACCOUNT_EMAIL}
        )
        return body["CreateAccountStatus"]["AccountId"]

    def create_ou(self, parent_id: str, name: str = INT_OU_NAME) -> str:
        _, body = self.post("CreateOrganizationalUnit", {"ParentId": parent_id, "Name": name})
        return body["OrganizationalUnit"]["Id"]

    def create_policy(self, name: str = INT_POLICY_NAME) -> str:
        _, body = self.post(
            "CreatePolicy",
            {
                "Name": name,
                "Description": "integration test policy",
                "Content": "{}",
                "Type": INT_POLICY_TYPE,
            },
        )
        return body["Policy"]["PolicySummary"]["Id"]

    def attach_policy(self, policy_id: str, target_id: str) -> None:
        self.post("AttachPolicy", {"PolicyId": policy_id, "TargetId": target_id})
