"""Given: a Lambda function has been deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoLambdaTestClient


@given("a Lambda function has been deployed")
def cognito_lambda_function_has_been_deployed(lws_session):
    CognitoLambdaTestClient(lws_session).create_function()
