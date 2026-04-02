"""When: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import CognitoLambdaTestClient


@when(
    'a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured'
)
def user_signs_up_without_trigger(lws_session, world):
    try:
        pool_id = CognitoLambdaTestClient(lws_session).get_pool_id()
        if pool_id is None:
            raise ClientError(
                {
                    "Error": {
                        "Code": "ResourceNotFoundException",
                        "Message": "Pool not found",
                    }
                },
                "AdminCreateUser",
            )
        resp = lws_session.client("cognito-idp").admin_create_user(
            UserPoolId=pool_id, Username="e2e-test-user-1", MessageAction="SUPPRESS"
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
