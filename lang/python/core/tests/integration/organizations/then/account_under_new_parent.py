"""Then: the "organizations" "account" will be under the new parent"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@then('the "organizations" "account" will be under the new parent')
def account_under_new_parent(client: TestClient, world):
    assert world["error"] is None, f"Expected MoveAccount to succeed but got: {world['error']}"
    account_id = world["account_id"]
    dest_parent_id = world["dest_parent_id"]
    _, list_body = OrganizationsTestClient(client).post(
        "ListAccountsForParent", {"ParentId": dest_parent_id}
    )
    actual_account_ids = [a["Id"] for a in list_body.get("Accounts", [])]
    assert (
        account_id in actual_account_ids
    ), f"Expected account '{account_id}' under dest parent but found: {actual_account_ids}"
