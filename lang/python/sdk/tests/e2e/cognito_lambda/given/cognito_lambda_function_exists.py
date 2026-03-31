"""Given: the "lambda" "function" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoLambdaTestClient


@given('the "lambda" "function" existed')
def cognito_lambda_function_exists(lws_session):
    CognitoLambdaTestClient(lws_session).create_function()
