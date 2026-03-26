"""Given: the table exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given('the table exists and is "ACTIVE"')
def apigw_dynamodb_table_exists_and_active(lws_session):
    ApigatewayDynamodbTestClient(lws_session).create_table()
