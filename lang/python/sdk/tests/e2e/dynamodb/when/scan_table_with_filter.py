"""When: all "dynamodb" "item"s in the "dynamodb" "table" are scanned with a filter expression"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE


@when('all "dynamodb" "item"s in the "dynamodb" "table" are scanned with a filter expression')
def scan_table_with_filter(lws_session, world):
    try:
        world["result"] = DynamodbTestClient(lws_session).scan_with_filter(TEST_TABLE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
