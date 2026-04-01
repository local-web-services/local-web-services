"""Given: a "lambda" "event source mapping" is created to process the DynamoDB Stream"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient


@given('a "lambda" "event source mapping" is created to process the DynamoDB Stream')
def dynamodb_lambda_esm_has_been_created(lws_session):
    DynamodbLambdaTestClient(lws_session).create_table_with_stream()
    DynamodbLambdaTestClient(lws_session).create_function()
    DynamodbLambdaTestClient(lws_session).create_esm()
