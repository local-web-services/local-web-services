"""When: an admin sets a "cognito" "user" password"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PASSWORD, TEST_USERNAME, _skip_if_not_implemented


@when('an admin sets a "cognito" "user" password')
def admin_set_user_password(lws_session, world):
    try:
        pool_id = world.get("pool_id", "")
        username = world.get("username", TEST_USERNAME)
        world["result"] = lws_session.client("cognito-idp").admin_set_user_password(
            UserPoolId=pool_id, Username=username, Password=TEST_PASSWORD, Permanent=True
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        _skip_if_not_implemented(exc)
        world["result"] = None
        world["error"] = exc
