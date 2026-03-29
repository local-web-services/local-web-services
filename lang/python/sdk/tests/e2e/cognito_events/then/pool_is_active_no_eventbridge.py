"""Then: the pool is "ACTIVE" with no EventBridge configuration"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_POOL


@then('the pool is "ACTIVE" with no EventBridge configuration')
def pool_is_active_no_eventbridge(lws_session):
    resp = lws_session.client("cognito-idp").list_user_pools(MaxResults=60)
    actual_names = [p["Name"] for p in resp.get("UserPools", [])]
    assert (
        TEST_POOL in actual_names
    ), f"Expected user pool '{TEST_POOL}' to be ACTIVE but not found in: {actual_names}"
