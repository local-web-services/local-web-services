"""Given: the user is "CONFIRMED" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import CognitoIdpTestClient
from ..constants import TEST_PASSWORD, TEST_TEMP_PASSWORD, TEST_USERNAME, _skip_if_not_implemented


@given('the user is "CONFIRMED"')
def user_is_confirmed(lws_session, world):
    """Ensure the user is in CONFIRMED state by using AdminSetUserPassword."""
    if not world.get("pool_id"):
        world["pool_id"] = CognitoIdpTestClient(lws_session).create_pool()
    client = CognitoIdpTestClient(lws_session)
    try:
        client.admin_create_user(
            UserPoolId=world["pool_id"],
            Username=TEST_USERNAME,
            TemporaryPassword=TEST_TEMP_PASSWORD,
        )
    except Exception:
        pass
    try:
        client.admin_set_user_password(
            UserPoolId=world["pool_id"],
            Username=TEST_USERNAME,
            Password=TEST_PASSWORD,
            Permanent=True,
        )
    except ClientError as exc:
        _skip_if_not_implemented(exc)
        raise
    world["username"] = TEST_USERNAME
