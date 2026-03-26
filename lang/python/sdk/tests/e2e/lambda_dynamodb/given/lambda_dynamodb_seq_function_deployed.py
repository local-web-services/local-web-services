"""Given: a Lambda function has been deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaDynamodbTestClient


@given("a Lambda function has been deployed")
def lambda_dynamodb_seq_function_deployed(lws_session):
    LambdaDynamodbTestClient(lws_session).create_function()
