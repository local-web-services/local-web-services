"""Given: a "cognito" "user pool" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoLambdaTestClient


@given('a "cognito" "user pool" is created')
def cognito_lambda_user_pool_has_been_created(lws_session):
    CognitoLambdaTestClient(lws_session).create_pool()
