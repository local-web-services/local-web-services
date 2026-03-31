"""Then: the "cognito" "user pool" will be "DELETED" along with all its users and groups"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_POOL_NAME


@then('the "cognito" "user pool" will be "DELETED" along with all its users and groups')
def pool_is_deleted_with_users_groups_then(lws_session):
    client = lws_session.client("cognito-idp")
    resp = client.list_user_pools(MaxResults=10)
    actual_pools = [p["Name"] for p in resp.get("UserPools", [])]
    assert (
        TEST_POOL_NAME not in actual_pools
    ), f"Expected pool '{TEST_POOL_NAME}' to be deleted but found in: {actual_pools}"
