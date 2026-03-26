"""Given: a change to the DynamoDB table has produced a stream record"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient
from ..constants import TEST_TABLE


@given("a change to the DynamoDB table has produced a stream record")
def dynamodb_lambda_stream_record_produced(lws_session):
    DynamodbLambdaTestClient(lws_session).create_table_with_stream()
    DynamodbLambdaTestClient(lws_session)._dynamodb.put_item(
        TableName=TEST_TABLE, Item={"id": {"S": "seq-record-1"}}
    )
