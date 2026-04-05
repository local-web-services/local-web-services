"""Test client for dynamodb tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import (
    GSI_INDEX,
    GSI_PK,
    GSI_PK_VALUE,
    GSI_TABLE,
    TEST_ATTR_VAL,
    TEST_ITEM_KEY,
    TEST_PK,
    TEST_TABLE,
)


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

    def create_gsi_table(self, name=GSI_TABLE):
        try:
            self._client.create_table(
                TableName=name,
                KeySchema=[{"AttributeName": TEST_PK, "KeyType": "HASH"}],
                AttributeDefinitions=[
                    {"AttributeName": TEST_PK, "AttributeType": "S"},
                    {"AttributeName": GSI_PK, "AttributeType": "S"},
                ],
                GlobalSecondaryIndexes=[
                    {
                        "IndexName": GSI_INDEX,
                        "KeySchema": [{"AttributeName": GSI_PK, "KeyType": "HASH"}],
                        "Projection": {"ProjectionType": "ALL"},
                    }
                ],
                BillingMode="PAY_PER_REQUEST",
            )
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "ResourceInUseException":
                return
            raise

    def put_gsi_item(self, name=GSI_TABLE):
        self._client.put_item(
            TableName=name,
            Item={
                TEST_PK: {"S": TEST_ITEM_KEY},
                GSI_PK: {"S": GSI_PK_VALUE},
            },
        )

    def query_gsi(self, name=GSI_TABLE):
        return self._client.query(
            TableName=name,
            IndexName=GSI_INDEX,
            KeyConditionExpression="#gsi_pk = :gsi_val",
            ExpressionAttributeNames={"#gsi_pk": GSI_PK},
            ExpressionAttributeValues={":gsi_val": {"S": GSI_PK_VALUE}},
        )
