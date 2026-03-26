"""When: a table is described"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE


@when("a table is described")
def describe_table(lws_session, world):
    try:
        world["result"] = DynamodbTestClient(lws_session).describe_table(TableName=TEST_TABLE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
