"""Given: an "AVAILABLE" record exists in the mapped table's stream"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient
from ..constants import TEST_TABLE


@given('an "AVAILABLE" record exists in the mapped table\'s stream')
def dynamodb_lambda_available_record_exists(lws_session):
    DynamodbLambdaTestClient(lws_session).create_table_with_stream()
    DynamodbLambdaTestClient(lws_session).create_function()
    DynamodbLambdaTestClient(lws_session).create_esm()
    DynamodbLambdaTestClient(lws_session)._dynamodb.put_item(
        TableName=TEST_TABLE, Item={"id": {"S": "trigger-record-1"}}
    )
