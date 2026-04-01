"""Given: the "cognito" "user pool" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaCognitoTestClient


@given('the "cognito" "user pool" already existed')
def pool_already_exists(lws_session):
    LambdaCognitoTestClient(lws_session).create_pool()
