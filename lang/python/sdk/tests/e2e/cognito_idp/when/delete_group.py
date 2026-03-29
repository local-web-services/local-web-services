"""When: a group is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_GROUP_NAME, _skip_if_not_implemented


@when("a group is deleted")
def delete_group(lws_session, world):
    try:
        pool_id = world.get("pool_id", "")
        group_name = world.get("group_name", TEST_GROUP_NAME)
        world["result"] = lws_session.client("cognito-idp").delete_group(
            GroupName=group_name, UserPoolId=pool_id
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        _skip_if_not_implemented(exc)
        world["result"] = None
        world["error"] = exc
