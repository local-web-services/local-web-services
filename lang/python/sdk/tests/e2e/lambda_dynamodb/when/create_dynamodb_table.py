"""When: a "dynamodb" "table" is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaDynamodbTestClient
from ..constants import TEST_TABLE


@when('a "dynamodb" "table" is created')
def create_dynamodb_table(lws_session, world):
    try:
        LambdaDynamodbTestClient(lws_session).create_table()
        world["result"] = {"TableName": TEST_TABLE}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
