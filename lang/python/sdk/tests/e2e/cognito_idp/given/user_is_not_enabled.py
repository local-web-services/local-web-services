"""Given: the user is not enabled"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoIdpTestClient
from ..constants import TEST_USERNAME


@given("the user is not enabled")
def user_is_not_enabled(lws_session, world):
    """Disable the user."""
    if not world.get("username"):
        world["username"] = TEST_USERNAME
    if not world.get("pool_id"):
        world["pool_id"] = CognitoIdpTestClient(lws_session).create_pool()
    try:
        CognitoIdpTestClient(lws_session).admin_disable_user(
            UserPoolId=world["pool_id"], Username=world["username"]
        )
    except Exception:
        pass
