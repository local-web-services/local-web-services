"""Given: a table deletion has completed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE


@given("a table deletion has completed")
def dynamodb_table_deletion_completed(lws_session):
    DynamodbTestClient(lws_session).create_table()
    DynamodbTestClient(lws_session).delete_table(TableName=TEST_TABLE)
