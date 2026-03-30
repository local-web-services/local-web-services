"""Given: the user is not "CONFIRMED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoIdpTestClient
from ..constants import TEST_PASSWORD, TEST_TEMP_PASSWORD, TEST_USERNAME


@given('the user is not "CONFIRMED"')
def user_is_not_confirmed(lws_session, world):
    """Ensure the user is in FORCE_CHANGE_PASSWORD (unconfirmed) state."""
    # Arrange
    if not world.get("pool_id"):
        world["pool_id"] = CognitoIdpTestClient(lws_session).create_pool()
    client = lws_session.client("cognito-idp")
    try:
        client.admin_delete_user(UserPoolId=world["pool_id"], Username=TEST_USERNAME)
    except Exception:  # noqa: BLE001
        pass
    # Act: create user, reset to RESET_REQUIRED, then set non-permanent password
    client.admin_create_user(
        UserPoolId=world["pool_id"],
        Username=TEST_USERNAME,
        TemporaryPassword=TEST_TEMP_PASSWORD,
    )
    client.admin_reset_user_password(
        UserPoolId=world["pool_id"],
        Username=TEST_USERNAME,
    )
    client.admin_set_user_password(
        UserPoolId=world["pool_id"],
        Username=TEST_USERNAME,
        Password=TEST_PASSWORD,
        Permanent=False,
    )
    world["username"] = TEST_USERNAME
