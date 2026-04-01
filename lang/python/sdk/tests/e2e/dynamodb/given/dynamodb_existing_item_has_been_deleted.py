"""Given: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@given('an existing "dynamodb" "item" is deleted from the "dynamodb" "table"')
def dynamodb_existing_item_has_been_deleted(lws_session):
    DynamodbTestClient(lws_session).create_table()
    DynamodbTestClient(lws_session).put_item()
    DynamodbTestClient(lws_session).delete_item(
        TableName=TEST_TABLE, Key={TEST_PK: {"S": TEST_ITEM_KEY}}
    )
