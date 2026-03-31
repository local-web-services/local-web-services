"""Given: the "cognito" "user pool" is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaCognitoTestClient


@given('the "cognito" "user pool" is already "DELETED"')
def pool_is_already_deleted(lws_session, world):
    pool_id = LambdaCognitoTestClient(lws_session).pool_id()
    if pool_id:
        LambdaCognitoTestClient(lws_session)._cognito.delete_user_pool(UserPoolId=pool_id)
    world["result"] = None
    world["error"] = None
