"""Given: the function already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoLambdaTestClient


@given("the function already exists")
def cognito_lambda_function_already_exists(lws_session):
    CognitoLambdaTestClient(lws_session).create_function()
