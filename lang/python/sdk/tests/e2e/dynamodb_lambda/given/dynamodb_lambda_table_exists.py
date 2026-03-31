"""Given: the "dynamodb" "table" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient


@given('the "dynamodb" "table" existed')
def dynamodb_lambda_table_exists(lws_session):
    DynamodbLambdaTestClient(lws_session).create_table()
