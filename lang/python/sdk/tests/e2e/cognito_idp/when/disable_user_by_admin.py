"""When: a user account is disabled by an admin"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import CognitoIdpTestClient
from ..constants import TEST_USERNAME, _skip_if_not_implemented


@when("a user account is disabled by an admin")
def disable_user_by_admin(lws_session, world):
    try:
        pool_id = world.get("pool_id", "")
        username = world.get("username", TEST_USERNAME)
        world["result"] = CognitoIdpTestClient(lws_session).admin_disable_user(
            UserPoolId=pool_id, Username=username
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        _skip_if_not_implemented(exc)
        world["result"] = None
        world["error"] = exc
