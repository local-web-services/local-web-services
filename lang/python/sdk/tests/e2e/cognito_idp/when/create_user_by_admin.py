"""When: a user is created by an admin in an active user pool"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import CognitoIdpTestClient
from ..constants import TEST_TEMP_PASSWORD, TEST_USERNAME, _skip_if_not_implemented


@when("a user is created by an admin in an active user pool")
def create_user_by_admin(lws_session, world):
    try:
        pool_id = world.get("pool_id", "")
        resp = CognitoIdpTestClient(lws_session).admin_create_user(
            UserPoolId=pool_id, Username=TEST_USERNAME, TemporaryPassword=TEST_TEMP_PASSWORD
        )
        world["result"] = resp
        world["username"] = TEST_USERNAME
        world["error"] = None
    except (ClientError, Exception) as exc:
        _skip_if_not_implemented(exc)
        world["result"] = None
        world["error"] = exc
