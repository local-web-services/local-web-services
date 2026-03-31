"""Given: the "dynamodb" "table" did not exist or was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient
from ..constants import TEST_TABLE


@given('the "dynamodb" "table" did not exist or was "ACTIVE"')
def apigw_dynamodb_table_not_exist_or_not_active(lws_session, world):
    try:
        lws_session.client("dynamodb").delete_table(TableName=TEST_TABLE)
    except Exception:
        pass
    lws_session.lifecycle("dynamodb").create_dwell_ms(5000).apply()
    ApigatewayDynamodbTestClient(lws_session).create_table()
    world["result"] = None
    world["error"] = None
