"""Given: the "dynamodb" "table" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaDynamodbTestClient
from ..constants import TEST_TABLE


@given('the "dynamodb" "table" was not "ACTIVE"')
def table_is_not_active_given(lws_session, world):
    try:
        LambdaDynamodbTestClient(lws_session)._dynamo.delete_table(TableName=TEST_TABLE)
    except Exception:
        pass
    lws_session.lifecycle("dynamodb").create_dwell_ms(5000).apply()
    LambdaDynamodbTestClient(lws_session).create_table()
    world["result"] = None
    world["error"] = None
