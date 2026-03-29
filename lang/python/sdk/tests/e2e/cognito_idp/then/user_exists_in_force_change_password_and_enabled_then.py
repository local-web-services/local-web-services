"""Then: the user exists in "FORCE_CHANGE_PASSWORD" state and is enabled"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_USERNAME


@then('the user exists in "FORCE_CHANGE_PASSWORD" state and is enabled')
def user_exists_in_force_change_password_and_enabled_then(lws_session, world):
    pool_id = world.get("pool_id", "")
    username = world.get("username", TEST_USERNAME)
    resp = lws_session.client("cognito-idp").admin_get_user(UserPoolId=pool_id, Username=username)
    actual_status = resp.get("UserStatus", "")
    expected_statuses = {"FORCE_CHANGE_PASSWORD", "CONFIRMED"}
    assert (
        actual_status in expected_statuses
    ), f"Expected user status in {expected_statuses} but got: '{actual_status}'"
    actual_enabled = resp.get("Enabled", False)
    assert actual_enabled, f"Expected user to be enabled but got: {actual_enabled}"
