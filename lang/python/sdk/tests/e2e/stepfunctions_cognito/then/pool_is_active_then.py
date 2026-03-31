"""Then: the "cognito" "user pool" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_POOL


@then('the "cognito" "user pool" will be "ACTIVE"')
def pool_is_active_then(lws_session):
    resp = lws_session.client("cognito-idp").list_user_pools(MaxResults=60)
    expected_pool_name = TEST_POOL
    actual_pool_names = [p["Name"] for p in resp.get("UserPools", [])]
    assert (
        expected_pool_name in actual_pool_names
    ), f"Expected pool '{expected_pool_name}' to exist but got: {actual_pool_names}"
