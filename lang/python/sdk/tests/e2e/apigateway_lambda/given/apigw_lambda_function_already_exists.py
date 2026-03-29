"""Given: the function already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayLambdaTestClient


@given("the function already exists")
def apigw_lambda_function_already_exists(lws_session):
    ApigatewayLambdaTestClient(lws_session).create_function()
