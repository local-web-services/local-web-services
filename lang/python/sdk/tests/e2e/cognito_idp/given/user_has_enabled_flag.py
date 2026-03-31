"""Given: the "cognito" "user" had an enabled flag"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoIdpTestClient
from ..constants import TEST_TEMP_PASSWORD, TEST_USERNAME


@given('the "cognito" "user" had an enabled flag')
def user_has_enabled_flag(lws_session, world):
    """Ensure a user exists (all Cognito users have an enabled flag)."""
    if not world.get("pool_id"):
        world["pool_id"] = CognitoIdpTestClient(lws_session).create_pool()
    try:
        CognitoIdpTestClient(lws_session).admin_create_user(
            UserPoolId=world["pool_id"],
            Username=TEST_USERNAME,
            TemporaryPassword=TEST_TEMP_PASSWORD,
        )
    except Exception:
        pass
    world["username"] = TEST_USERNAME
