"""Given: a "dynamodb" "table" deletion completes"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE


@given('a "dynamodb" "table" deletion completes')
def dynamodb_table_deletion_completed(lws_session):
    DynamodbTestClient(lws_session).create_table()
    DynamodbTestClient(lws_session).delete_table(TableName=TEST_TABLE)
