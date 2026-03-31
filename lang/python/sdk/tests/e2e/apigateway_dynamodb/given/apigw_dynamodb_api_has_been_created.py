"""Given: an "api gateway" "api" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given('an "api gateway" "api" is created')
@given('an "api gateway" "api" is created')
def apigw_dynamodb_api_has_been_created(lws_session):
    ApigatewayDynamodbTestClient(lws_session).create_api()
