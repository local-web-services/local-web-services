"""Given: the "dynamodb" "table" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given('the "dynamodb" "table" existed and was "ACTIVE"')
def apigw_dynamodb_table_exists_and_active(lws_session):
    ApigatewayDynamodbTestClient(lws_session).create_table()
