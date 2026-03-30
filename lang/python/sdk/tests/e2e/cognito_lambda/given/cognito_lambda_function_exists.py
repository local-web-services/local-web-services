"""Given: the function exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoLambdaTestClient


@given("the function exists")
def cognito_lambda_function_exists(lws_session):
    CognitoLambdaTestClient(lws_session).create_function()
