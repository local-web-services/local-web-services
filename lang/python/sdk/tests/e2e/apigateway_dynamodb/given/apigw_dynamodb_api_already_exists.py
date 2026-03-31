"""Given: the "api gateway" "API" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given('the "api gateway" "API" already existed')
def apigw_dynamodb_api_already_exists(lws_session):
    ApigatewayDynamodbTestClient(lws_session).create_api()
