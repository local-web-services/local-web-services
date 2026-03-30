"""Given: a DynamoDB table has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given("a DynamoDB table has been created")
def apigw_dynamodb_table_has_been_created(lws_session):
    ApigatewayDynamodbTestClient(lws_session).create_table()
