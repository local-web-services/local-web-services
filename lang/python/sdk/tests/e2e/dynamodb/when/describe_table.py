"""When: a "dynamodb" "table" is described"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_TABLE


@when('a "dynamodb" "table" is described')
def describe_table(lws_session, world):
    try:
        world["result"] = lws_session.client("dynamodb").describe_table(TableName=TEST_TABLE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
