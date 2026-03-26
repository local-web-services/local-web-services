"""Given: aid in api_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayLambdaTestClient


@given("aid in api_status")
def apigw_lambda_aid_in_api_status(lws_session):
    ApigatewayLambdaTestClient(lws_session).create_api()
