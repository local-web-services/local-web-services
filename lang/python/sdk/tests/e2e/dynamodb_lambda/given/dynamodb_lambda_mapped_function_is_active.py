"""Given: the mapped function was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient


@given('the mapped function was "ACTIVE"')
def dynamodb_lambda_mapped_function_is_active(lws_session):
    DynamodbLambdaTestClient(lws_session).create_table_with_stream()
    DynamodbLambdaTestClient(lws_session).create_function()
    DynamodbLambdaTestClient(lws_session).create_esm()
