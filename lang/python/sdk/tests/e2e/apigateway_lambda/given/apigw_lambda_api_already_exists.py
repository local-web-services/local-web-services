"""Given: the "api gateway" "API" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayLambdaTestClient


@given('the "api gateway" "API" already existed')
def apigw_lambda_api_already_exists(lws_session):
    ApigatewayLambdaTestClient(lws_session).create_api()
