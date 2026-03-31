"""Given: the "cognito" "user pool" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsCognitoTestClient


@given('the "cognito" "user pool" existed')
def pool_exists(lws_session):
    StepfunctionsCognitoTestClient(lws_session).create_pool()
