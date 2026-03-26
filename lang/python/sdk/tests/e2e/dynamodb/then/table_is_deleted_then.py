"""Then: the table is deleted"""

from __future__ import annotations

from pytest_bdd import then

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE


@then("the table is deleted")
def table_is_deleted_then(lws_session):
    client = DynamodbTestClient(lws_session).dynamo()
    resp = client.list_tables()
    actual_tables = resp.get("TableNames", [])
    assert (
        TEST_TABLE not in actual_tables
    ), f"Expected table '{TEST_TABLE}' to be deleted but found in: {actual_tables}"
