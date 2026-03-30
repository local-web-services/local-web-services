"""Given: the user is "CONFIRMED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoIdpTestClient
from ..constants import TEST_PASSWORD, TEST_USERNAME


@given('the user is "CONFIRMED"')
def user_is_confirmed(lws_session, world):
    """Ensure the user is in CONFIRMED state with TEST_PASSWORD via delete-and-recreate."""
    if not world.get("pool_id"):
        world["pool_id"] = CognitoIdpTestClient(lws_session).create_pool()
    client = lws_session.client("cognito-idp")
    try:
        client.admin_delete_user(UserPoolId=world["pool_id"], Username=TEST_USERNAME)
    except Exception:
        pass
    client.admin_create_user(
        UserPoolId=world["pool_id"],
        Username=TEST_USERNAME,
        TemporaryPassword=TEST_PASSWORD,
    )
    world["username"] = TEST_USERNAME
