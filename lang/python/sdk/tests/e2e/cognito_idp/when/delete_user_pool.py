"""When: a user pool is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import CognitoIdpTestClient
from ..constants import _skip_if_not_implemented


@when("a user pool is deleted")
def delete_user_pool(lws_session, world):
    try:
        pool_id = world.get("pool_id", "")
        world["result"] = CognitoIdpTestClient(lws_session).delete_user_pool(UserPoolId=pool_id)
        world["error"] = None
    except (ClientError, Exception) as exc:
        _skip_if_not_implemented(exc)
        world["result"] = None
        world["error"] = exc
