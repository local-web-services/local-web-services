"""Then: the table is marked as "DELETED" and all its items are removed"""

from __future__ import annotations

from pytest_bdd import then

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE


@then('the table is marked as "DELETED" and all its items are removed')
def table_marked_deleted_then(lws_session):
    client = DynamodbTestClient(lws_session).dynamo()
    resp = client.list_tables()
    actual_tables = resp.get("TableNames", [])
    assert (
        TEST_TABLE not in actual_tables
    ), f"Expected table '{TEST_TABLE}' to be deleted but found in: {actual_tables}"
