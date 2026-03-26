"""Then: the user is "FORCE_CHANGE_PASSWORD" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_USERNAME


@then('the user is "FORCE_CHANGE_PASSWORD"')
def user_is_force_change_password_then(lws_session, world):
    pool_id = world.get("pool_id", "")
    username = world.get("username", TEST_USERNAME)
    resp = lws_session.client("cognito-idp").admin_get_user(UserPoolId=pool_id, Username=username)
    actual_status = resp.get("UserStatus", "")
    expected_status = "FORCE_CHANGE_PASSWORD"
    assert (
        actual_status == expected_status
    ), f"Expected user status '{expected_status}' but got: '{actual_status}'"
