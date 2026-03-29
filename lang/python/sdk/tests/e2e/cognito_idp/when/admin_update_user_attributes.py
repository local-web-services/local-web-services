"""When: an admin updates attributes for a confirmed user"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_USERNAME, _skip_if_not_implemented


@when("an admin updates attributes for a confirmed user")
def admin_update_user_attributes(lws_session, world):
    try:
        pool_id = world.get("pool_id", "")
        username = world.get("username", TEST_USERNAME)
        world["result"] = lws_session.client("cognito-idp").admin_update_user_attributes(
            UserPoolId=pool_id,
            Username=username,
            UserAttributes=[{"Name": "email_verified", "Value": "true"}],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        _skip_if_not_implemented(exc)
        world["result"] = None
        world["error"] = exc
