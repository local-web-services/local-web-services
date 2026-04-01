"""Given: the "lambda" "function" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient


@given('the "lambda" "function" already existed')
def dynamodb_lambda_function_already_exists(lws_session):
    DynamodbLambdaTestClient(lws_session).create_function()
