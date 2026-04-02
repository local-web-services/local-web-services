"""Test client for dynamodb tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import TEST_ATTR_VAL, TEST_ITEM_KEY, TEST_PK, TEST_TABLE


class DynamodbTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("dynamodb")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_table(self, name=TEST_TABLE):
        try:
            self._client.create_table(
                TableName=name,
                KeySchema=[{"AttributeName": TEST_PK, "KeyType": "HASH"}],
                AttributeDefinitions=[{"AttributeName": TEST_PK, "AttributeType": "S"}],
                BillingMode="PAY_PER_REQUEST",
            )
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "ResourceInUseException":
                return
            raise

    def put_item(self, name=TEST_TABLE):
        self._client.put_item(
            TableName=name,
            Item={TEST_PK: {"S": TEST_ITEM_KEY}, "data": {"S": TEST_ATTR_VAL}},
        )
