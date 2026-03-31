"""Given: a "lambda" "function" is deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayLambdaTestClient


@given('a "lambda" "function" is deployed')
def apigw_lambda_function_has_been_deployed(lws_session):
    ApigatewayLambdaTestClient(lws_session).create_function()
