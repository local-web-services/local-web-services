"""When: a Cognito user pool is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaCognitoTestClient


@when("a Cognito user pool is created")
def create_cognito_user_pool(lws_session, world):
    try:
        resp = LambdaCognitoTestClient(lws_session).create_pool()
        world["result"] = {"UserPoolId": resp}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
