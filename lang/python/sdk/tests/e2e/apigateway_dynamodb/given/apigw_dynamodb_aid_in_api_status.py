"""Given: aid in api_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given("aid in api_status")
def apigw_dynamodb_aid_in_api_status(lws_session):
    ApigatewayDynamodbTestClient(lws_session).create_api()
