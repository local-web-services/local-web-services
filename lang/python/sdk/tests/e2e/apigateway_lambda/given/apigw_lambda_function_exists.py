"""Given: the "lambda" "function" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayLambdaTestClient


@given('the "lambda" "function" existed')
def apigw_lambda_function_exists(lws_session):
    ApigatewayLambdaTestClient(lws_session).create_function()
