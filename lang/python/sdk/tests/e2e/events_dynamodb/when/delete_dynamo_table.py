"""When: a "dynamodb" "table" deletion is initiated"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_TABLE


@when('a "dynamodb" "table" deletion is initiated')
def delete_dynamo_table(lws_session, world):
    try:
        world["result"] = lws_session.client("dynamodb").delete_table(TableName=TEST_TABLE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
