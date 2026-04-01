"""Then: the "cognito" "user pool" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_POOL_NAME


@then('the "cognito" "user pool" will be "ACTIVE"')
def pool_is_active_then(lws_session):
    client = lws_session.client("cognito-idp")
    resp = client.list_user_pools(MaxResults=10)
    actual_pools = [p["Name"] for p in resp.get("UserPools", [])]
    expected_pool = TEST_POOL_NAME
    assert any(
        expected_pool == name for name in actual_pools
    ), f"Expected pool '{expected_pool}' to exist but not found in: {actual_pools}"
