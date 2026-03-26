"""Then: the user is "CONFIRMED" """

from __future__ import annotations

from pytest_bdd import then

from ..client import CognitoIdpTestClient
from ..constants import TEST_USERNAME


@then('the user is "CONFIRMED"')
def user_is_confirmed_then(lws_session, world):
    pool_id = world.get("pool_id", "")
    username = world.get("username", TEST_USERNAME)
    resp = CognitoIdpTestClient(lws_session).admin_get_user(UserPoolId=pool_id, Username=username)
    actual_status = resp.get("UserStatus", "")
    expected_status = "CONFIRMED"
    assert (
        actual_status == expected_status
    ), f"Expected user status '{expected_status}' but got: '{actual_status}'"
