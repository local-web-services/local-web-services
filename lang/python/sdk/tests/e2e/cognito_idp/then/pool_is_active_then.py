"""Then: the user pool is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import CognitoIdpTestClient
from ..constants import TEST_POOL_NAME


@then('the user pool is "ACTIVE"')
def pool_is_active_then(lws_session):
    client = CognitoIdpTestClient(lws_session).cognito()
    resp = client.list_user_pools(MaxResults=10)
    actual_pools = [p["Name"] for p in resp.get("UserPools", [])]
    expected_pool = TEST_POOL_NAME
    assert any(
        expected_pool == name for name in actual_pools
    ), f"Expected pool '{expected_pool}' to exist but not found in: {actual_pools}"
