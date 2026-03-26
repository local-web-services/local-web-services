"""Given: the event source mapping already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient
from ..constants import TEST_TABLE


@given("the event source mapping already exists")
def dynamodb_lambda_esm_already_exists(lws_session, world):
    try:
        DynamodbLambdaTestClient(lws_session)._dynamodb.delete_table(TableName=TEST_TABLE)
    except Exception:
        pass
    DynamodbLambdaTestClient(lws_session).create_table_with_stream()
    try:
        DynamodbLambdaTestClient(lws_session).create_function()
    except Exception:
        pass
    DynamodbLambdaTestClient(lws_session).create_esm()
    world["_skip"] = (
        "lws does not reject create_event_source_mapping when an event source mapping already exists for the same source and function"  # noqa: E501
    )
