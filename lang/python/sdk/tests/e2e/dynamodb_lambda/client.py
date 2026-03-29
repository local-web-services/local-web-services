"""Test client for dynamodb_lambda tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_FUNC, TEST_TABLE, _stream_arn


class DynamodbLambdaTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _dynamodb = lws_session.client("dynamodb")
        self._dynamodb = _dynamodb
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda

    def create_table(self, name=TEST_TABLE):
        self._dynamodb.create_table(
            TableName=name,
            KeySchema=[{"AttributeName": "id", "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": "id", "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
        )

    def create_table_with_stream(self, name=TEST_TABLE):
        try:
            self._dynamodb.create_table(
                TableName=name,
                KeySchema=[{"AttributeName": "id", "KeyType": "HASH"}],
                AttributeDefinitions=[{"AttributeName": "id", "AttributeType": "S"}],
                BillingMode="PAY_PER_REQUEST",
                StreamSpecification={"StreamEnabled": True, "StreamViewType": "NEW_AND_OLD_IMAGES"},
            )
        except Exception:
            pass

    def create_function(self, name=TEST_FUNC):
        try:
            self._lambda.create_function(
                FunctionName=name,
                Runtime="python3.12",
                Role=ROLE_ARN,
                Handler="index.handler",
                Code={"ZipFile": b"fake"},
            )
        except Exception:
            pass

    def create_esm(self, table_name=TEST_TABLE, function_name=TEST_FUNC):
        return self._lambda.create_event_source_mapping(
            EventSourceArn=_stream_arn(table_name),
            FunctionName=function_name,
            StartingPosition="TRIM_HORIZON",
        )
