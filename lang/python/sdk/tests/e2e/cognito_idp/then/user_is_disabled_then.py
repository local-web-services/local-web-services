"""Then: the "cognito" "user" will be "DISABLED" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_USERNAME


@then('the "cognito" "user" will be "DISABLED"')
def user_is_disabled_then(lws_session, world):
    pool_id = world.get("pool_id", "")
    username = world.get("username", TEST_USERNAME)
    resp = lws_session.client("cognito-idp").admin_get_user(UserPoolId=pool_id, Username=username)
    actual_enabled = resp.get("Enabled", True)
    assert not actual_enabled, f"Expected user to be disabled but got enabled: {actual_enabled}"
