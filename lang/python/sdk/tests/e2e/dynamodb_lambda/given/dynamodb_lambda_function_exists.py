"""Given: the function exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient


@given("the function exists")
def dynamodb_lambda_function_exists(lws_session):
    DynamodbLambdaTestClient(lws_session).create_function()
