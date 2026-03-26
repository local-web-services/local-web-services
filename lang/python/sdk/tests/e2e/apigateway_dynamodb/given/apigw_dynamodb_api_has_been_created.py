"""Given: an API Gateway REST API has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given("an API Gateway REST API has been created")
@given('an "API" Gateway "REST" "API" has been created')
def apigw_dynamodb_api_has_been_created(lws_session):
    ApigatewayDynamodbTestClient(lws_session).create_api()
