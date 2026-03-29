"""Given: a Lambda function has been deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbLambdaTestClient


@given("a Lambda function has been deployed")
def dynamodb_lambda_function_has_been_deployed(lws_session):
    DynamodbLambdaTestClient(lws_session).create_function()
