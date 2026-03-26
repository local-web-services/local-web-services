"""Then: the account is "ACTIVE" under the root"""

from __future__ import annotations

from pytest_bdd import then

from ..client import OrganizationsTestClient


@then('the account is "ACTIVE" under the root')
def account_active_under_root(lws_session, world):
    assert world["error"] is None, f"Expected CreateAccount to succeed but got: {world['error']}"
    account_id = world["account_id"]
    account_resp = OrganizationsTestClient(lws_session).describe_account(AccountId=account_id)
    actual_status = account_resp["Account"]["Status"]
    expected_status = "ACTIVE"
    assert (
        actual_status == expected_status
    ), f"Expected account status '{expected_status}' but got '{actual_status}'"
    root_id = world["root_id"]
    list_resp = OrganizationsTestClient(lws_session).list_accounts_for_parent(ParentId=root_id)
    actual_account_ids = [a["Id"] for a in list_resp.get("Accounts", [])]
    assert (
        account_id in actual_account_ids
    ), f"Expected account '{account_id}' under root but found: {actual_account_ids}"
