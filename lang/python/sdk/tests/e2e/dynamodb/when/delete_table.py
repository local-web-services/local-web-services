"""When: a table is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE


@when("a table is deleted")
def delete_table(lws_session, world):
    try:
        world["result"] = DynamodbTestClient(lws_session).delete_table(TableName=TEST_TABLE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
