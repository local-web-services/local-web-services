"""Given: the "cognito" "user pool" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoLambdaTestClient


@given('the "cognito" "user pool" already existed')
def cognito_lambda_pool_already_exists(lws_session):
    CognitoLambdaTestClient(lws_session).create_pool()
