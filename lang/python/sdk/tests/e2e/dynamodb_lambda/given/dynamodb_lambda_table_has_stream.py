"""Given: the table has a stream enabled"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient
from ..constants import TEST_TABLE


@given("the table has a stream enabled")
def dynamodb_lambda_table_has_stream(lws_session):
    try:
        DynamodbLambdaTestClient(lws_session)._dynamodb.delete_table(TableName=TEST_TABLE)
    except Exception:
        pass
    DynamodbLambdaTestClient(lws_session).create_table_with_stream()
