"""Given: the user is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoIdpTestClient
from ..constants import TEST_TEMP_PASSWORD, TEST_USERNAME


@given('the user is already "DELETED"')
def user_is_already_deleted(lws_session, world):
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
    CognitoIdpTestClient(lws_session).admin_delete_user(
        UserPoolId=world["pool_id"], Username=TEST_USERNAME
    )
    world["result"] = None
    world["error"] = None
