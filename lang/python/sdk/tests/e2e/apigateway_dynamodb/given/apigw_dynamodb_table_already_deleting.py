"""Given: the "dynamodb" "table" is already "DELETING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient
from ..constants import TEST_TABLE


@given('the "dynamodb" "table" is already "DELETING"')
def apigw_dynamodb_table_already_deleting(lws_session, world):
    ApigatewayDynamodbTestClient(lws_session).create_table()
    lws_session.lifecycle("dynamodb").delete_dwell_ms(5000).apply()
    try:
        lws_session.client("dynamodb").delete_table(TableName=TEST_TABLE)
    except Exception:
        pass
    world["result"] = None
    world["error"] = None
