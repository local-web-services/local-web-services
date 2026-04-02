"""Given: the "lambda" "event source mapping" was "ENABLED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient


@given('the "lambda" "event source mapping" was "ENABLED"')
def dynamodb_lambda_esm_is_enabled(lws_session):
    DynamodbLambdaTestClient(lws_session).create_table_with_stream()
    DynamodbLambdaTestClient(lws_session).create_function()
    DynamodbLambdaTestClient(lws_session).create_esm()
