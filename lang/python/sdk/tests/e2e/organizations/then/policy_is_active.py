"""Then: the "organizations" "policy" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then


@then('the "organizations" "policy" will be "ACTIVE"')
def policy_is_active(lws_session, world):
    assert world["error"] is None, f"Expected CreatePolicy to succeed but got: {world['error']}"
    policy_id = world["policy_id"]
    policy_resp = lws_session.client("organizations").describe_policy(PolicyId=policy_id)
    actual_id = policy_resp["Policy"]["PolicySummary"]["Id"]
    assert (
        actual_id is not None
    ), f"Expected policy Id to be set but got None for policy_id={policy_id}"
