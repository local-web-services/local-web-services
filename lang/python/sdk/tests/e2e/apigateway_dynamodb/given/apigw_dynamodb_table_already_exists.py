"""Given: the "dynamodb" "table" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given('the "dynamodb" "table" already existed')
def apigw_dynamodb_table_already_exists(lws_session):
    ApigatewayDynamodbTestClient(lws_session).create_table()
