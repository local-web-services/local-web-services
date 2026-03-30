"""Given: a Lambda function has been deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayLambdaTestClient


@given("a Lambda function has been deployed")
def apigw_lambda_function_has_been_deployed(lws_session):
    ApigatewayLambdaTestClient(lws_session).create_function()
