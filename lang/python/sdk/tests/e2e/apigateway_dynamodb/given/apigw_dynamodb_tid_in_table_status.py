"""Given: tid in table_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given("tid in table_status")
def apigw_dynamodb_tid_in_table_status(lws_session):
    ApigatewayDynamodbTestClient(lws_session).create_table()
