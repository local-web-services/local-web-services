"""Given: the "dynamodb" "table" is already "DELETING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient
from ..constants import TEST_TABLE


@given('the "dynamodb" "table" is already "DELETING"')
def table_is_already_deleting(lws_session, world):
    try:
        EventsDynamodbTestClient(lws_session)._dynamo.delete_table(TableName=TEST_TABLE)
    except Exception:
        pass
    EventsDynamodbTestClient(lws_session).create_table()
    lws_session.lifecycle("dynamodb").delete_dwell_ms(5000).apply()
    EventsDynamodbTestClient(lws_session)._dynamo.delete_table(TableName=TEST_TABLE)
    world["result"] = None
    world["error"] = None
