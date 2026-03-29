"""Given: the target table is "DELETING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient
from ..constants import TEST_TABLE


@given('the target table is "DELETING"')
def target_table_is_deleting(lws_session, world):
    try:
        EventsDynamodbTestClient(lws_session)._dynamo.delete_table(TableName=TEST_TABLE)
    except Exception:
        pass
    EventsDynamodbTestClient(lws_session).create_table()
    lws_session.lifecycle("dynamodb").delete_dwell_ms(5000).apply()
    EventsDynamodbTestClient(lws_session)._dynamo.delete_table(TableName=TEST_TABLE)
    world["result"] = None
    world["error"] = None
