"""Given: the "dynamodb" "table" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE


@given('the "dynamodb" "table" was not "ACTIVE"')
def table_is_not_active_given(lws_session):
    """Enable lifecycle dwell, delete the existing ACTIVE table, and recreate it so it stays
    in CREATING state."""
    lws_session.lifecycle("dynamodb").create_dwell_ms(5000).apply()
    DynamodbTestClient(lws_session).delete_table(TableName=TEST_TABLE)
    DynamodbTestClient(lws_session).create_table()
