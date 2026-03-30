"""When: a user pool is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_POOL_NAME, _skip_if_not_implemented


@when("a user pool is created")
def create_user_pool(lws_session, world):
    try:
        resp = lws_session.client("cognito-idp").create_user_pool(PoolName=TEST_POOL_NAME)
        world["result"] = resp
        world["pool_id"] = resp["UserPool"]["Id"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        _skip_if_not_implemented(exc)
        world["result"] = None
        world["error"] = exc
