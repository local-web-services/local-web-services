"""When: a change to the DynamoDB table produces a stream record"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import DynamodbLambdaTestClient
from ..constants import TEST_TABLE


@when("a change to the DynamoDB table produces a stream record")
def table_change_produces_record(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    try:
        resp = DynamodbLambdaTestClient(lws_session)._dynamodb.put_item(
            TableName=TEST_TABLE, Item={"id": {"S": "stream-record-1"}, "data": {"S": "test-value"}}
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
