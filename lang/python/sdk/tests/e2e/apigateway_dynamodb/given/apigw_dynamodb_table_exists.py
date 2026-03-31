"""Given: the "dynamodb" "table" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given('the "dynamodb" "table" existed')
def apigw_dynamodb_table_exists(lws_session):
    ApigatewayDynamodbTestClient(lws_session).create_table()
