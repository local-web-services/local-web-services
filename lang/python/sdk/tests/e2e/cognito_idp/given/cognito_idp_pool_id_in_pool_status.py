"""Given: pool_id in pool_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoIdpTestClient


@given("pool_id in pool_status")
def cognito_idp_pool_id_in_pool_status(lws_session, world):
    world["pool_id"] = CognitoIdpTestClient(lws_session).create_pool()
