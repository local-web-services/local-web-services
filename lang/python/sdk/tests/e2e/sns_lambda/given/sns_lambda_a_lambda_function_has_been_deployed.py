"""Given: a "lambda" "function" is deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsLambdaTestClient


@given('a "lambda" "function" is deployed')
def sns_lambda_a_lambda_function_has_been_deployed(lws_session):
    SnsLambdaTestClient(lws_session).create_function()
