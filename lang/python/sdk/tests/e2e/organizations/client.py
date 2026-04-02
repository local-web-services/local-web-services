"""Test client for organizations tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import (
    TEST_ACCOUNT_EMAIL,
    TEST_ACCOUNT_NAME,
    TEST_OU_NAME,
    TEST_POLICY_NAME,
    TEST_POLICY_TYPE,
)


class OrganizationsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("organizations")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_org(self):
        try:
            return self._client.create_organization(FeatureSet="ALL")
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "AlreadyInOrganizationException":
                resp = self._client.describe_organization()
                return {"Organization": resp["Organization"]}
            raise

    def get_root_id(self):
        resp = self._client.list_roots()
        return resp["Roots"][0]["Id"]

    def create_account(self):
        try:
            resp = self._client.create_account(
                AccountName=TEST_ACCOUNT_NAME, Email=TEST_ACCOUNT_EMAIL
            )
            return resp["CreateAccountStatus"]["AccountId"]
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "DuplicateAccountException":
                resp = self._client.list_accounts()
                for account in resp.get("Accounts", []):
                    if account.get("Email") == TEST_ACCOUNT_EMAIL:
                        return account["Id"]
            raise

    def create_ou(self, parent_id, name=TEST_OU_NAME):
        try:
            resp = self._client.create_organizational_unit(ParentId=parent_id, Name=name)
            return resp["OrganizationalUnit"]["Id"]
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "DuplicateOrganizationalUnitException":
                resp = self._client.list_organizational_units_for_parent(ParentId=parent_id)
                for ou in resp.get("OrganizationalUnits", []):
                    if ou["Name"] == name:
                        return ou["Id"]
            raise

    def create_policy(self, name=TEST_POLICY_NAME):
        try:
            resp = self._client.create_policy(
                Name=name,
                Description="e2e test policy",
                Content="{}",
                Type=TEST_POLICY_TYPE,
            )
            return resp["Policy"]["PolicySummary"]["Id"]
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "DuplicatePolicyException":
                resp = self._client.list_policies(Filter=TEST_POLICY_TYPE)
                for policy in resp.get("Policies", []):
                    if policy["Name"] == name:
                        return policy["Id"]
            raise

    def attach_policy(self, policy_id, target_id):
        try:
            self._client.attach_policy(PolicyId=policy_id, TargetId=target_id)
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "DuplicatePolicyAttachmentException":
                return
            raise

    def move_account(self, account_id, source_parent_id, dest_parent_id):
        self._client.move_account(
            AccountId=account_id,
            SourceParentId=source_parent_id,
            DestinationParentId=dest_parent_id,
        )

    def tag_resource(self, resource_id, tags: dict):
        tags_list = [{"Key": k, "Value": v} for k, v in tags.items()]
        self._client.tag_resource(ResourceId=resource_id, Tags=tags_list)

    def list_tags_for_resource(self, resource_id):
        return self._client.list_tags_for_resource(ResourceId=resource_id)

    def list_children(self, parent_id, child_type):
        return self._client.list_children(ParentId=parent_id, ChildType=child_type)
