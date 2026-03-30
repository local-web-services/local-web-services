"""Given: the table already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient


@given("the table already exists")
def dynamodb_lambda_table_already_exists(lws_session):
    DynamodbLambdaTestClient(lws_session).create_table()
