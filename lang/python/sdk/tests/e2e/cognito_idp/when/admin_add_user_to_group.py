"""When: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_GROUP_NAME, TEST_USERNAME, _skip_if_not_implemented


@when('an admin adds a "cognito" "user" to a "cognito" "group" in the same pool')
def admin_add_user_to_group(lws_session, world):
    try:
        pool_id = world.get("pool_id", "")
        username = world.get("username", TEST_USERNAME)
        group_name = world.get("group_name", TEST_GROUP_NAME)
        world["result"] = lws_session.client("cognito-idp").admin_add_user_to_group(
            UserPoolId=pool_id, Username=username, GroupName=group_name
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        _skip_if_not_implemented(exc)
        world["result"] = None
        world["error"] = exc
