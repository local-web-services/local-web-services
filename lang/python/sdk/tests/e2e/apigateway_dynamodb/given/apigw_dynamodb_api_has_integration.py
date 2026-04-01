"""Given: the "api gateway" "api" has a "dynamodb" integration configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given('the "api gateway" "api" has a "dynamodb" integration configured')
def apigw_dynamodb_api_has_integration(lws_session, world):
    api_id = ApigatewayDynamodbTestClient(lws_session).get_api_id()
    if api_id is None:
        api_id = ApigatewayDynamodbTestClient(lws_session).create_api()
    ApigatewayDynamodbTestClient(lws_session).create_table()
    ApigatewayDynamodbTestClient(lws_session).configure_dynamodb_integration(api_id)
    world["api_id"] = api_id
