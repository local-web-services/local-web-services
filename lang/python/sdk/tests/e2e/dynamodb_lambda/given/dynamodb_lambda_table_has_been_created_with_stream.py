"""Given: a "dynamodb" "table" is created with streaming enabled"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient


@given('a "dynamodb" "table" is created with streaming enabled')
def dynamodb_lambda_table_has_been_created_with_stream(lws_session):
    DynamodbLambdaTestClient(lws_session).create_table_with_stream()
