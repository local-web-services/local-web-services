"""When: a "cognito" "user pool" is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsCognitoTestClient


@when('a "cognito" "user pool" is deleted')
def delete_user_pool(lws_session, world):
    try:
        pool_id = StepfunctionsCognitoTestClient(lws_session).get_pool_id()
        if pool_id is None:
            raise ClientError(
                {"Error": {"Code": "ResourceNotFoundException", "Message": "Pool not found"}},
                "DeleteUserPool",
            )
        resp = lws_session.client("cognito-idp").delete_user_pool(UserPoolId=pool_id)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
