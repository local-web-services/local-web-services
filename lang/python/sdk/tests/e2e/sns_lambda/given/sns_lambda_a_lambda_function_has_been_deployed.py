"""Given: a Lambda function has been deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsLambdaTestClient


@given("a Lambda function has been deployed")
def sns_lambda_a_lambda_function_has_been_deployed(lws_session):
    SnsLambdaTestClient(lws_session).create_function()
