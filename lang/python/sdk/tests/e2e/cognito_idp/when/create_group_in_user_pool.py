"""When: a "cognito" "group" is created in an active "cognito" "user pool" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_GROUP_NAME, _skip_if_not_implemented


@when('a "cognito" "group" is created in an active "cognito" "user pool"')
def create_group_in_user_pool(lws_session, world):
    try:
        pool_id = world.get("pool_id", "")
        resp = lws_session.client("cognito-idp").create_group(
            GroupName=TEST_GROUP_NAME, UserPoolId=pool_id
        )
        world["result"] = resp
        world["group_name"] = TEST_GROUP_NAME
        world["error"] = None
    except (ClientError, Exception) as exc:
        _skip_if_not_implemented(exc)
        world["result"] = None
        world["error"] = exc
