"""Given: the "cognito" "user pool" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoLambdaTestClient


@given('the "cognito" "user pool" was not "ACTIVE"')
def cognito_lambda_pool_is_not_active_given(lws_session, world):
    try:
        pool_id = CognitoLambdaTestClient(lws_session).get_pool_id()
        if pool_id is not None:
            CognitoLambdaTestClient(lws_session)._cognito.delete_user_pool(UserPoolId=pool_id)
    except Exception:
        pass
    lws_session.lifecycle("cognito-idp").create_dwell_ms(5000).apply()
    CognitoLambdaTestClient(lws_session).create_pool()
    world["result"] = None
    world["error"] = None
