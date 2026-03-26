"""Test client for dynamodb tests."""

from __future__ import annotations

from starlette.testclient import TestClient

from .constants import TEST_ATTR_VAL, TEST_ITEM_KEY, TEST_PK, TEST_TABLE


class DynamodbTestClient:
    def __init__(self, client):
        self._client = client

    def post(self, target: str, body: dict) -> TestClient:
        return self._client.post(
            "/", headers={"X-Amz-Target": f"DynamoDB_20120810.{target}"}, json=body
        )

    def create_table(self, name: str = TEST_TABLE) -> None:
        self.post(
            "CreateTable",
            {
                "TableName": name,
                "KeySchema": [{"AttributeName": TEST_PK, "KeyType": "HASH"}],
                "AttributeDefinitions": [{"AttributeName": TEST_PK, "AttributeType": "S"}],
                "BillingMode": "PAY_PER_REQUEST",
            },
        )

    def put_item(self, name: str = TEST_TABLE) -> None:
        self.post(
            "PutItem",
            {
                "TableName": name,
                "Item": {TEST_PK: {"S": TEST_ITEM_KEY}, "data": {"S": TEST_ATTR_VAL}},
            },
        )
