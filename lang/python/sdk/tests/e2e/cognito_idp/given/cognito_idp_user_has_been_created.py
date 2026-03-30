"""Given: a user has been created by an admin in an active user pool"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoIdpTestClient
from ..constants import TEST_TEMP_PASSWORD, TEST_USERNAME


@given("a user has been created by an admin in an active user pool")
def cognito_idp_user_has_been_created(lws_session, world):
    if not world.get("pool_id"):
        world["pool_id"] = CognitoIdpTestClient(lws_session).create_pool()
    CognitoIdpTestClient(lws_session).admin_create_user(
        UserPoolId=world["pool_id"], Username=TEST_USERNAME, TemporaryPassword=TEST_TEMP_PASSWORD
    )
    world["username"] = TEST_USERNAME
