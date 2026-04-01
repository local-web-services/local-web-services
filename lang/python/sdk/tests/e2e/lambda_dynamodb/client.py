"""Test client for lambda_dynamodb tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_FUNC, TEST_PK, TEST_TABLE


class LambdaDynamodbTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda
        _dynamo = lws_session.client("dynamodb")
        self._dynamo = _dynamo

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )

    def create_table(self, name=TEST_TABLE):
        self._dynamo.create_table(
            TableName=name,
            KeySchema=[{"AttributeName": TEST_PK, "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": TEST_PK, "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
        )
