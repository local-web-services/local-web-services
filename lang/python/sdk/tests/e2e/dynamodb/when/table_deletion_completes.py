"""When: a table deletion completes"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_TABLE


@when("a table deletion completes")
def table_deletion_completes(lws_session, world):
    """Complete a table deletion - in lws, table deletions complete immediately."""
    try:
        world["result"] = lws_session.client("dynamodb").delete_table(TableName=TEST_TABLE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
