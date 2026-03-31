"""Given: the "lambda" "function" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayLambdaTestClient


@given('the "lambda" "function" already existed')
def apigw_lambda_function_already_exists(lws_session):
    ApigatewayLambdaTestClient(lws_session).create_function()
