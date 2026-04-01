"""When: all "dynamodb" "item"s in the "dynamodb" "table" are scanned"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_TABLE


@when('all "dynamodb" "item"s in the "dynamodb" "table" are scanned')
def scan_table(lws_session, world):
    try:
        world["result"] = lws_session.client("dynamodb").scan(TableName=TEST_TABLE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
