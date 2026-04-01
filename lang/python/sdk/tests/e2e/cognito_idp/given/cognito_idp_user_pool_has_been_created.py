"""Given: a user pool has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoIdpTestClient


@given("a user pool has been created")
def cognito_idp_user_pool_has_been_created(lws_session, world):
    world["pool_id"] = CognitoIdpTestClient(lws_session).create_pool()
