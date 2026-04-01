"""When: a "lambda" "event source mapping" is created to process the DynamoDB Stream"""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import DynamodbLambdaTestClient


@when('a "lambda" "event source mapping" is created to process the DynamoDB Stream')
def create_event_source_mapping(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    try:
        resp = DynamodbLambdaTestClient(lws_session).create_esm()
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
