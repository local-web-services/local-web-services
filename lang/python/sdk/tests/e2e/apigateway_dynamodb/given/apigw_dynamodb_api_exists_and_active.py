"""Given: the "API" exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given('the "API" exists and is "ACTIVE"')
def apigw_dynamodb_api_exists_and_active(lws_session):
    ApigatewayDynamodbTestClient(lws_session).create_api()
