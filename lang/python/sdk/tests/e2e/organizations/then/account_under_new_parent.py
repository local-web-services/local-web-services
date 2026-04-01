"""Then: the "organizations" "account" will be under the new parent"""

from __future__ import annotations

from pytest_bdd import then


@then('the "organizations" "account" will be under the new parent')
def account_under_new_parent(lws_session, world):
    assert world["error"] is None, f"Expected MoveAccount to succeed but got: {world['error']}"
    account_id = world["account_id"]
    dest_parent_id = world["dest_parent_id"]
    list_resp = lws_session.client("organizations").list_accounts_for_parent(
        ParentId=dest_parent_id
    )
    actual_account_ids = [a["Id"] for a in list_resp.get("Accounts", [])]
    assert (
        account_id in actual_account_ids
    ), f"Expected account '{account_id}' under dest parent but found: {actual_account_ids}"
