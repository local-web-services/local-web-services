"""When: a user pool is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import CognitoIdpTestClient
from ..constants import TEST_POOL_NAME, _skip_if_not_implemented


@when("a user pool is created")
def create_user_pool(lws_session, world):
    try:
        resp = CognitoIdpTestClient(lws_session).create_user_pool(PoolName=TEST_POOL_NAME)
        world["result"] = resp
        world["pool_id"] = resp["UserPool"]["Id"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        _skip_if_not_implemented(exc)
        world["result"] = None
        world["error"] = exc
