"""When: a Cognito User Pool is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_POOL


@when("a Cognito User Pool is created")
def create_cognito_user_pool(lws_session, world):
    try:
        resp = lws_session.client("cognito-idp").create_user_pool(PoolName=TEST_POOL)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
