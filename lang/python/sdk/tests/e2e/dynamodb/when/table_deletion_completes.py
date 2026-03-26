"""When: a table deletion completes"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE


@when("a table deletion completes")
def table_deletion_completes(lws_session, world):
    """Complete a table deletion - in lws, table deletions complete immediately."""
    try:
        world["result"] = DynamodbTestClient(lws_session).delete_table(TableName=TEST_TABLE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
