"""Given: the user pool already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoIdpTestClient


@given("the user pool already exists")
def pool_already_exists(lws_session, world):
    world["pool_id"] = CognitoIdpTestClient(lws_session).create_pool()
