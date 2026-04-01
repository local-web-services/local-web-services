"""Given: a "cognito" "user pool" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsCognitoTestClient


@given('a "cognito" "user pool" is created')
def cognito_pool_has_been_created(lws_session):
    StepfunctionsCognitoTestClient(lws_session).create_pool()
