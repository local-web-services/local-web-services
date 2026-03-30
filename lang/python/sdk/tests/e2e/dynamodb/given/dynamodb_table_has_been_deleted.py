"""Given: a table has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE


@given("a table has been deleted")
def dynamodb_table_has_been_deleted(lws_session):
    DynamodbTestClient(lws_session).create_table()
    DynamodbTestClient(lws_session).delete_table(TableName=TEST_TABLE)
