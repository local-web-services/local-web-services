"""Given: a user pool has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoIdpTestClient


@given("a user pool has been deleted")
def cognito_idp_user_pool_has_been_deleted(lws_session, world):
    pool_id = CognitoIdpTestClient(lws_session).create_pool()
    CognitoIdpTestClient(lws_session).delete_user_pool(UserPoolId=pool_id)
    world["pool_id"] = pool_id
