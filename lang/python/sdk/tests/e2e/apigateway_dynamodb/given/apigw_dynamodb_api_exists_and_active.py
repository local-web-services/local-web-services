"""Given: the "api gateway" "API" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given('the "api gateway" "API" existed and was "ACTIVE"')
def apigw_dynamodb_api_exists_and_active(lws_session):
    ApigatewayDynamodbTestClient(lws_session).create_api()
