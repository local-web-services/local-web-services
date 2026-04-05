"""When: "dynamodb" "item"s are queried from a "dynamodb" "GSI" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import DynamodbTestClient


@when('"dynamodb" "item"s are queried from a "dynamodb" "GSI"')
def query_gsi(lws_session, world):
    # Arrange
    c = DynamodbTestClient(lws_session)

    # Act
    try:
        world["result"] = c.query_gsi()
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc
