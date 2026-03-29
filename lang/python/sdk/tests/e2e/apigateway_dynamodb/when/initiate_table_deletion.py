"""When: a table deletion is initiated"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_TABLE


@when("a table deletion is initiated")
def initiate_table_deletion(lws_session, world):
    try:
        resp = lws_session.client("dynamodb").delete_table(TableName=TEST_TABLE)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
