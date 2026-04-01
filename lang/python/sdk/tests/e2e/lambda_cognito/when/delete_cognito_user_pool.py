"""When: a "cognito" "user pool" is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaCognitoTestClient


@when('a "cognito" "user pool" is deleted')
def delete_cognito_user_pool(lws_session, world):
    try:
        pool_id = LambdaCognitoTestClient(lws_session).pool_id()
        lws_session.client("cognito-idp").delete_user_pool(UserPoolId=pool_id)
        world["result"] = {"UserPoolId": pool_id}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
