"""Then: the pool is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_POOL


@then('the pool is "ACTIVE"')
def apigw_cognito_pool_is_active_then(lws_session):
    resp = lws_session.client("cognito-idp").list_user_pools(MaxResults=60)
    actual_pool_names = [p["Name"] for p in resp.get("UserPools", [])]
    expected_pool_name = TEST_POOL
    assert (
        expected_pool_name in actual_pool_names
    ), f"Expected pool '{expected_pool_name}' to be ACTIVE but not found in: {actual_pool_names}"
