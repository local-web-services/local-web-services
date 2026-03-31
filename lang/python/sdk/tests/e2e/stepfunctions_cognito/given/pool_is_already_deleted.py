"""Given: the "cognito" "user pool" is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsCognitoTestClient


@given('the "cognito" "user pool" is already "DELETED"')
def pool_is_already_deleted(lws_session, world):
    try:
        pool_id = StepfunctionsCognitoTestClient(lws_session).create_pool()
    except Exception:
        pool_id = StepfunctionsCognitoTestClient(lws_session).get_pool_id()
    if pool_id:
        lws_session.lifecycle("cognito-idp").delete_dwell_ms(5000).apply()
        try:
            StepfunctionsCognitoTestClient(lws_session)._cognito.delete_user_pool(
                UserPoolId=pool_id
            )
        except Exception:
            pass
    world["result"] = None
    world["error"] = None
