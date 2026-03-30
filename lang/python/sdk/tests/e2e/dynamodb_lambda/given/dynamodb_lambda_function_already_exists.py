"""Given: the function already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient


@given("the function already exists")
def dynamodb_lambda_function_already_exists(lws_session):
    DynamodbLambdaTestClient(lws_session).create_function()
