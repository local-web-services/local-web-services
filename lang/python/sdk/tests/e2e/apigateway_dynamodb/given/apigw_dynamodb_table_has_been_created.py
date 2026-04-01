"""Given: a "dynamodb" "table" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given('a "dynamodb" "table" is created')
def apigw_dynamodb_table_has_been_created(lws_session):
    ApigatewayDynamodbTestClient(lws_session).create_table()
