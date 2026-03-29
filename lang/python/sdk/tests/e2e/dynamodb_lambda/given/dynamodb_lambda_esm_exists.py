"""Given: the event source mapping exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient


@given("the event source mapping exists")
def dynamodb_lambda_esm_exists(lws_session):
    DynamodbLambdaTestClient(lws_session).create_table_with_stream()
    DynamodbLambdaTestClient(lws_session).create_function()
    DynamodbLambdaTestClient(lws_session).create_esm()
