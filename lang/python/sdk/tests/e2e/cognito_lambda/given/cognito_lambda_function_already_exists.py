"""Given: the "lambda" "function" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoLambdaTestClient


@given('the "lambda" "function" already existed')
def cognito_lambda_function_already_exists(lws_session):
    CognitoLambdaTestClient(lws_session).create_function()
