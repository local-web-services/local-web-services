"""Given: the target "dynamodb" "table" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient


@given('the target "dynamodb" "table" was "ACTIVE"')
def apigw_dynamodb_target_table_is_active(lws_session):
    try:
        ApigatewayDynamodbTestClient(lws_session).create_table()
    except Exception:
        pass
