"""Then: the table is "DELETED" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TABLE


@then('the table is "DELETED"')
def table_is_deleted_status_then(lws_session):
    client = lws_session.client("dynamodb")
    resp = client.list_tables()
    actual_tables = resp.get("TableNames", [])
    assert (
        TEST_TABLE not in actual_tables
    ), f"Expected table '{TEST_TABLE}' to be DELETED but found in: {actual_tables}"
