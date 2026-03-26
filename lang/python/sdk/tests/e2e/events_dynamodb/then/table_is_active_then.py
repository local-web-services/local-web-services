"""Then: the table is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import EventsDynamodbTestClient
from ..constants import TEST_TABLE


@then('the table is "ACTIVE"')
def table_is_active_then(lws_session):
    resp = EventsDynamodbTestClient(lws_session)._dynamo.list_tables()
    actual_tables = resp.get("TableNames", [])
    assert (
        TEST_TABLE in actual_tables
    ), f"Expected table '{TEST_TABLE}' to be ACTIVE but not found in: {actual_tables}"
