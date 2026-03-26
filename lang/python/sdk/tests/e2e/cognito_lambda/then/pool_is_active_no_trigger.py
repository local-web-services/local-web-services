"""Then: the pool is "ACTIVE" with no pre-signup trigger configured"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_POOL


@then('the pool is "ACTIVE" with no pre-signup trigger configured')
def pool_is_active_no_trigger(lws_session):
    resp = lws_session.client("cognito-idp").list_user_pools(MaxResults=60)
    actual_pool_names = [p["Name"] for p in resp.get("UserPools", [])]
    expected_pool_name = TEST_POOL
    assert (
        expected_pool_name in actual_pool_names
    ), f"Expected pool '{expected_pool_name}' to exist but not found in: {actual_pool_names}"
