"""Given: a REST API has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayLambdaTestClient


@given("a REST API has been created")
@given('a "REST" "API" has been created')
def apigw_lambda_rest_api_has_been_created(lws_session):
    ApigatewayLambdaTestClient(lws_session).create_api()
